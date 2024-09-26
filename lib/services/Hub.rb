module Services
  class Hub
    def get_current_weather_for_zip(zip)
      with_cache("current_weather_for_zip:#{zip}") do
        location = open_weather_service.get_location_for_zip(zip)
        current_weather = open_weather_service.get_current_weather_for_coordinates(location.lat, location.lon)
        current_weather.location = location
        current_weather
      end
    end

    def get_forecast_for_zip(zip)
      with_cache("forecast_for_zip:#{zip}") do
        location = open_weather_service.get_location_for_zip(zip)
        url = noaa_service.get_forecast_url_for_coordinates(location.lat, location.lon)
        forecast = noaa_service.get_forecast_for_url(url)
        forecast.location = location
        forecast
      end
    end

    private

    def with_cache(key, &block)
      from_cache = true
      result = Rails.cache.fetch(key, expires_in: 30.minutes) do
        from_cache = false
        block.call
      end
      result.from_cache = from_cache # requires that the result object has a from_cache attribute
      result
    end

    def open_weather_service
      @open_weather_service ||= OpenWeatherService.new
    end

    def noaa_service
      @noaa_service ||= NoaaService.new
    end
  end
end
