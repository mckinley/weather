class CurrentWeatherController < ApplicationController
  rescue_from Services::ApiError, with: :api_error
  def index
    @address = Address.new(zip: params[:zip])
    if @address.valid?
      @current_weather = Services::OpenWeatherService.new.get_current_weather_for_zip(@address.zip)
    end
  end

  private
  def api_error
    @address.errors.add(:zip, "could not be found, or the OpenWeather API is down.")
    render :index
  end
end
