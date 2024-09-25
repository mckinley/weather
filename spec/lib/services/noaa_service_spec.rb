require 'rails_helper'

RSpec.describe Services::NoaaService do
  let(:coordinates) { { lat: 39.7456, lon: -97.0892 } }

  describe "#get_forecast_for_coordinates" do
    it "returns a forecast for coordinates" do
      VCR.use_cassette("noaa_service/get_forecast_for_coordinates") do
        forecast = Services::NoaaService.new.get_forecast_for_coordinates(coordinates[:lat], coordinates[:lon])
        expect(forecast.weather_details.map(&:name)).to eq [ "This Afternoon", "Tonight", "Thursday", "Thursday Night", "Friday", "Friday Night", "Saturday", "Saturday Night", "Sunday", "Sunday Night", "Monday", "Monday Night", "Tuesday", "Tuesday Night" ]
      end
    end

    it "returns weather details for each period" do
      VCR.use_cassette("noaa_service/get_forecast_for_coordinates") do
        forecast = Services::NoaaService.new.get_forecast_for_coordinates(coordinates[:lat], coordinates[:lon])
        weather_detail = forecast.weather_details.first
        expect(weather_detail.name).to eq "This Afternoon"
        expect(weather_detail.start_time).to eq "2024-09-25T15:00:00-05:00"
        expect(weather_detail.end_time).to eq "2024-09-25T18:00:00-05:00"
        expect(weather_detail.is_daytime).to eq true
        expect(weather_detail.temp).to eq 80
        expect(weather_detail.wind_speed).to eq "5 mph"
        expect(weather_detail.wind_direction).to eq "NE"
        expect(weather_detail.summary).to eq "Sunny"
        expect(weather_detail.description).to eq "Sunny, with a high near 80. Northeast wind around 5 mph."
      end
    end
  end
end
