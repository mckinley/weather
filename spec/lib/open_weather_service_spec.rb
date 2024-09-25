require 'rails_helper'

RSpec.describe OpenWeatherService do
  describe "#get_location_weather_for_zip" do
    it "returns a location and associated weather object that describes the current weather" do
      VCR.use_cassette("open_weather_service/get_location_weather_for_zip") do
        results = OpenWeatherService.new.get_location_weather_for_zip("98103")
        expect(results).to be_a(Location)
        expect(results.zip).to eq "98103"
        expect(results.lat).to eq 47.6733
        expect(results.lon).to eq -122.3426
        expect(results.name).to eq "Seattle"
        expect(results.country).to eq "US"

        weather = results.current_weather
        expect(weather).to be_a(WeatherDetail)
        expect(weather.temp).to eq 293.47
        expect(weather.feels_like).to eq 293.54
        expect(weather.temp_min).to eq 292.05
        expect(weather.temp_max).to eq 296.27
        expect(weather.pressure).to eq 1005
        expect(weather.humidity).to eq 76
        expect(weather.wind_speed).to eq 1.34
        expect(weather.summary).to eq "Clouds"
        expect(weather.description).to eq "few clouds"
      end
    end
  end
end
