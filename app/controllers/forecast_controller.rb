class ForecastController < ApplicationController
  rescue_from Services::ApiError, with: :api_error

  def index
    @address = Address.new(zip: params[:zip])
    render if params[:zip].nil?
    if @address.valid?
      @forecast = Services::Hub.new.get_forecast_for_zip(@address.zip)
    end
  end

  def api_error
    @address.errors.add(:zip, "could not be found, or a required service is currently down.")
    render :index
  end
end
