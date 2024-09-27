require "rails_helper"

RSpec.describe Services::OpenWeatherService, vcr: { cassette_name: "hub" } do
  describe "#get_location_for_zip" do
    let(:valid_zip) { "98103" }

    it "returns the location for a zip" do
      location = Services::OpenWeatherService.new.get_location_for_zip(valid_zip)
      expect(location).to be_a(Location)
      expect(location.zip).to eq "98103"
      expect(location.lat).to eq 47.6733
      expect(location.lon).to eq -122.3426
      expect(location.name).to eq "Seattle"
      expect(location.country).to eq "US"
    end

    context "when zip is not found" do
      it "raises an error" do
        expect { Services::OpenWeatherService.new.get_location_for_zip("00000") }.to raise_error(Services::ApiError)
      end
    end
  end

  describe "#get_current_weather_for_zip" do
    it "returns the current_weather for coordinates" do
      current_weather = Services::OpenWeatherService.new.get_current_weather_for_coordinates(47.6733, -122.3426)
      expect(current_weather).to be_a(WeatherData)
      expect(current_weather.temp).to eq 65.93
      expect(current_weather.feels_like).to eq 65.08
      expect(current_weather.temp_min).to eq 63.16
      expect(current_weather.temp_max).to eq 68.49
      expect(current_weather.pressure).to eq 1013
      expect(current_weather.humidity).to eq 61
      expect(current_weather.wind_speed).to eq 5.99
      expect(current_weather.summary).to eq "Clouds"
      expect(current_weather.description).to eq "overcast clouds"
    end

    context "when coordinates are not valid" do
      it "raises an error" do
        expect { Services::OpenWeatherService.new.get_current_weather_for_coordinates("invalid", "invalid") }.to raise_error(Services::ApiError)
      end
    end
  end
end
