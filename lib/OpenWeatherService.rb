require "faraday"

class OpenWeatherService
  def initialize
    @conn = Faraday.new(url: "https://api.openweathermap.org", params: { appid: ENV["OPEN_WEATHER_API_KEY"] })
  end

  def get_location_weather_for_zip(zip)
    # Rails.cache.exist? would introduce a race condition, so we are using the from_cache var.
    from_cache = true
    location = Rails.cache.fetch("OpenWeatherService#get_location_weather_for_zip:#{zip}", expires_in: 30.minutes) do
      from_cache = false
      location = get_location_for_zip(zip)
      weather = get_weather_for_coordinates(location.lat, location.lon)
      location.current_weather = weather
      location
    end
    location.from_cache = from_cache
    location
  end

  private

  def get_weather_for_coordinates(lat, lon)
    response = @conn.get("data/2.5/weather?lat=#{lat}&lon=#{lon}")
    weather_from_json(response)
  end

  def get_location_for_zip(zip)
    response = @conn.get("geo/1.0/zip?zip=#{zip}")
    location_from_json(response)
  end

  def location_from_json(json)
    hash = parse_json(json)
    location = Location.new
    location.zip = hash[:zip]
    location.lat = hash[:lat]
    location.lon = hash[:lon]
    location.name = hash[:name]
    location.country = hash[:country]
    location
  end

  def weather_from_json(json)
    hash = parse_json(json)
    weather = WeatherDetail.new
    weather.temp = hash[:main][:temp]
    weather.feels_like = hash[:main][:feels_like]
    weather.temp_min = hash[:main][:temp_min]
    weather.temp_max = hash[:main][:temp_max]
    weather.pressure = hash[:main][:pressure]
    weather.humidity = hash[:main][:humidity]
    weather.wind_speed = hash[:wind][:speed]
    weather.summary = hash[:weather][0][:main]
    weather.description = hash[:weather][0][:description]
    weather
  end

  def parse_json(response)
    if response.status != 200
      raise ApiError.new(response.status, response.body)
    end
    JSON.parse(response.body, symbolize_names: true)
  end
end
