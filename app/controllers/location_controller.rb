class LocationController < ApplicationController
  rescue_from ApiError, with: :api_error
  def index
    # As a quick solution for validating the zip, we are instantiating a Location object.
    if location.valid?
      @location = OpenWeatherService.new.get_location_weather_for_zip(location.zip)
    end
  end

  private
  def api_error
    location.errors.add(:zip, "could not be found, or the OpenWeather API is down.")
    render :index
  end

  def location
    @location ||= Location.new(params[:zip])
  end
end
