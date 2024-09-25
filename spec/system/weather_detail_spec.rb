require 'rails_helper'

RSpec.describe "Weather", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "shows the weather" do
    VCR.use_cassette("open_weather_service/get_weather") do
      visit "/"
      expect(page).to have_text("Weather")
    end
  end
end
