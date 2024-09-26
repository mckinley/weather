require 'rails_helper'

RSpec.describe Services::NoaaService, vcr: { cassette_name: "noaa_service/get_forecast_for_coordinates" } do
  let(:coordinates) { { lat: 39.7456, lon: -97.0892 } }

  describe "#get_forecast_for_coordinates" do
    it "returns a forecast for coordinates" do
      forecast = Services::NoaaService.new.get_forecast_for_coordinates(coordinates[:lat], coordinates[:lon])
      expect(forecast.weather_details.map(&:name)).to eq [ "This Afternoon", "Tonight", "Thursday", "Thursday Night", "Friday", "Friday Night", "Saturday", "Saturday Night", "Sunday", "Sunday Night", "Monday", "Monday Night", "Tuesday", "Tuesday Night" ]
    end

    it "returns weather details for each period" do
      forecast = Services::NoaaService.new.get_forecast_for_coordinates(coordinates[:lat], coordinates[:lon])
      weather = forecast.weather_details.first
      expect(weather.name).to eq "This Afternoon"
      expect(weather.start_time).to eq "2024-09-25T15:00:00-05:00"
      expect(weather.end_time).to eq "2024-09-25T18:00:00-05:00"
      expect(weather.is_daytime).to eq true
      expect(weather.temp).to eq 80
      expect(weather.wind_speed).to eq "5 mph"
      expect(weather.wind_direction).to eq "NE"
      expect(weather.summary).to eq "Sunny"
      expect(weather.description).to eq "Sunny, with a high near 80. Northeast wind around 5 mph."
    end
  end
end
