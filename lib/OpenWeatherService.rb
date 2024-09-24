require "faraday"

class OpenWeatherService
  def initialize
    @conn = Faraday.new(url: "https://api.openweathermap.org/data/2.5/weather")
  end

  def get_weather(city)
    response = @conn.get("?q=#{city}&appid=#{ENV['OPEN_WEATHER_API_KEY']}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
