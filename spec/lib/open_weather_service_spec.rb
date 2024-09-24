require 'rails_helper'

RSpec.describe OpenWeatherService do
  describe "#get_weather" do
    it "returns http success" do
      VCR.use_cassette("open_weather_service/get_weather") do
        results = OpenWeatherService.new.get_weather("Seattle")
        expect(results).to be_a(Hash)
      end
    end
  end
end
