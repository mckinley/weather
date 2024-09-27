require "faraday"

module Services
  class OpenWeatherService
    OPEN_WEATHER_API_KEY = ENV.fetch("OPEN_WEATHER_API_KEY", "openweatherapikey").freeze

    def initialize
      @conn = Faraday.new(url: "https://api.openweathermap.org", params: { appid: OPEN_WEATHER_API_KEY })
    end

    def get_location_for_zip(zip)
      response = @conn.get("geo/1.0/zip?zip=#{zip}")
      location_from_json(response)
    end

    def get_current_weather_for_coordinates(lat, lon)
      response = @conn.get("data/2.5/weather?lat=#{lat}&lon=#{lon}&units=imperial")
      current_weather_from_json(response)
    end

    private

    def location_from_json(json)
      hash = Services::Utils.parse_json(json)
      location = Location.new
      location.zip = hash[:zip]
      location.lat = hash[:lat]
      location.lon = hash[:lon]
      location.name = hash[:name]
      location.country = hash[:country]
      location
    end

    def current_weather_from_json(json)
      hash = Services::Utils.parse_json(json)
      weather = WeatherData.new
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
  end
end
