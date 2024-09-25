class WeatherController < ApplicationController
  def index
    @location = Location.new(params[:zip])
    if @location.valid?
      @location = OpenWeatherService.new.get_location_weather_for_zip(@location.zip)
    end
  end
end
