require "faraday"

module Services
  class NoaaService
    NOAA_API_CONTACT_WEBSITE = ENV.fetch("NOAA_API_CONTACT_WEBSITE", "noaaapicontactwebsite.com").freeze
    NOAA_API_CONTACT_EMAIL = ENV.fetch("NOAA_API_CONTACT_EMAIL", "admin@noaaapicontactwebsite.com").freeze

    def initialize
      @conn = Faraday.new(url: "https://api.weather.gov", headers: { user_agent: "(#{NOAA_API_CONTACT_WEBSITE}, #{NOAA_API_CONTACT_EMAIL})" })
    end

    def get_forecast_url_for_coordinates(lat, lon)
      response = @conn.get("points/#{lat},#{lon}")
      forecast_url_from_json(response)
    end

    def get_forecast_for_url(url)
      response = @conn.get(url)
      forecast_from_json(response)
    end

    private

    def forecast_url_from_json(json)
      hash = Utils.parse_json(json)
      hash[:properties][:forecast]
    end

    def forecast_from_json(json)
      hash = Utils.parse_json(json)
      forecast = Forecast.new
      forecast.weather_data = hash[:properties][:periods].map do |period|
        weather = WeatherData.new
        weather.name = period[:name]
        weather.start_time = period[:startTime]
        weather.end_time = period[:endTime]
        weather.is_daytime = period[:isDaytime]
        weather.temp = period[:temperature]
        weather.wind_speed = period[:windSpeed]
        weather.wind_direction = period[:windDirection]
        weather.summary = period[:shortForecast]
        weather.description = period[:detailedForecast]
        weather
      end
      forecast
    end
  end
end
