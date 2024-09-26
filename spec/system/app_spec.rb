require 'rails_helper'

RSpec.describe "App", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "renders current weather", vcr: { cassette_name: "open_weather_service/get_current_weather_for_zip" } do
    visit "/"
    expect(page).to have_text("Current Weather")
  end

  it "renders forecast", vcr: { cassette_name: "noaa_service/get_forecast_for_coordinates" } do
    visit "/forecast"
    expect(page).to have_text("Forecast")
  end
end
