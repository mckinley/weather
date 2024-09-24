class WeatherController < ApplicationController
  def index
    @weather = OpenWeatherService.new.get_weather("Seattle")
  end
end
