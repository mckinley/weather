require 'rails_helper'

RSpec.describe Services::OpenWeatherService, vcr: { cassette_name: "open_weather_service/get_current_weather_for_zip" } do
  describe "#get_current_weather_for_zip" do
    let(:valid_zip) { "98103" }

    it "returns a current_weather and associated weather object that describes the current weather" do
      current_weather = Services::OpenWeatherService.new.get_current_weather_for_zip(valid_zip)
      location = current_weather.location

      expect(location).to be_a(Location)
      expect(location.zip).to eq "98103"
      expect(location.lat).to eq 47.6733
      expect(location.lon).to eq -122.3426
      expect(location.name).to eq "Seattle"
      expect(location.country).to eq "US"

      expect(current_weather).to be_a(WeatherData)
      expect(current_weather.temp).to eq 292.08
      expect(current_weather.feels_like).to eq 292.12
      expect(current_weather.temp_min).to eq 290.61
      expect(current_weather.temp_max).to eq 293.87
      expect(current_weather.pressure).to eq 1005
      expect(current_weather.humidity).to eq 80
      expect(current_weather.wind_speed).to eq 0.89
      expect(current_weather.summary).to eq "Clear"
      expect(current_weather.description).to eq "clear sky"
    end

    context "when zip is not found" do
      it "returns nil" do
        expect { Services::OpenWeatherService.new.get_current_weather_for_zip("00000") }.to raise_error(Services::ApiError)
      end
    end
  end
end
