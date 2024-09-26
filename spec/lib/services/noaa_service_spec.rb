require "rails_helper"

RSpec.describe Services::NoaaService, vcr: { cassette_name: "hub" } do
  let(:coordinates) { { lat: 47.6733, lon: -122.3426 } }
  let(:url) { "https://api.weather.gov/gridpoints/SEW/125,71/forecast" }

  describe "#get_forecast_url_for_coordinates" do
    it "returns a forecast url for coordinates" do
      url = Services::NoaaService.new.get_forecast_url_for_coordinates(coordinates[:lat], coordinates[:lon])
      expect(url).to eq url
    end
  end

  describe "#get_forecast_for_url" do
    it "returns a forecast for a url" do
      forecast = Services::NoaaService.new.get_forecast_for_url(url)
      expect(forecast.weather_data.map(&:name)).to eq [ "Tonight", "Thursday", "Thursday Night", "Friday", "Friday Night", "Saturday", "Saturday Night", "Sunday", "Sunday Night", "Monday", "Monday Night", "Tuesday", "Tuesday Night", "Wednesday" ]
    end

    it "returns weather data for each period" do
      forecast = Services::NoaaService.new.get_forecast_for_url(url)
      weather = forecast.weather_data.first
      expect(weather.name).to eq "Tonight"
      expect(weather.start_time).to eq "2024-09-25T20:00:00-07:00"
      expect(weather.end_time).to eq "2024-09-26T06:00:00-07:00"
      expect(weather.is_daytime).to eq false
      expect(weather.temp).to eq 51
      expect(weather.wind_speed).to eq "6 mph"
      expect(weather.wind_direction).to eq "SE"
      expect(weather.summary).to eq "Slight Chance Showers And Thunderstorms then Mostly Cloudy"
      expect(weather.description).to eq "A chance of rain before 11pm, then a slight chance of showers and thunderstorms between 11pm and midnight. Mostly cloudy, with a low around 51. Southeast wind around 6 mph. Chance of precipitation is 50%. New rainfall amounts less than a tenth of an inch possible."
    end
  end
end
