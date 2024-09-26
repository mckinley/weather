class ForecastController < ApplicationController
  rescue_from Services::ApiError, with: :api_error

  def index
    @address = Address.new(zip: params[:zip])
    if @address.valid?
      @forecast = Services::Hub.new.get_forecast_for_zip(@address.zip)
    end
  end

  def api_error
    @forecast.errors.add(:zip, "could not be found, or a required service is currently down.")
    render :index
  end
end
