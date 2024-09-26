class ForecastController < ApplicationController
  rescue_from Services::ApiError, with: :api_error

  def index
    @address = Address.new(zip: params[:zip])
    if @address.valid?
      location = Services::OpenWeatherService.new.get_location_for_zip(@address.zip)
      @forecast = Services::NoaaService.new.get_forecast_for_coordinates(location.lat, location.lon)
      @forecast.location = location
    end
  end

  def api_error
    @forecast.errors.add(:zip, "could not be found, or a required service is currently down.")
    render :index
  end
end
