require 'rails_helper'

RSpec.describe "Location", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "renders" do
    VCR.use_cassette("open_weather_service/get_location_weather_for_zip") do
      visit "/"
      expect(page).to have_text("Weather")
    end
  end
end
