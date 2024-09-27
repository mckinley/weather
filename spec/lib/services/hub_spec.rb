require "rails_helper"

RSpec.describe Services::Hub, vcr: { cassette_name: "hub" } do
  let(:valid_zip) { "98103" }

  describe "#get_current_weather_for_zip" do
    it "returns current weather for a zip" do
      current_weather = Services::Hub.new.get_current_weather_for_zip(valid_zip)
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

    it "returns location for a zip" do
      current_weather = Services::Hub.new.get_current_weather_for_zip(valid_zip)
      validate_location(current_weather.location)
    end

    context "when cache is enabled" do
      let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

      before do
        allow(Rails).to receive(:cache).and_return(memory_store)
        Rails.cache.clear
      end

      after do
        Rails.cache.clear
      end

      it "returns from cache" do
        expect(Rails.cache.exist?("current_weather_for_zip:#{valid_zip}")).to eq false
        result = Services::Hub.new.get_current_weather_for_zip(valid_zip)
        expect(result.from_cache).to eq false

        expect(Rails.cache.exist?("current_weather_for_zip:#{valid_zip}")).to eq true
        result = Services::Hub.new.get_current_weather_for_zip(valid_zip)
        expect(result.from_cache).to eq true
      end
    end
  end

  describe "#get_forcast_for_zip" do
    it "returns forecast for a zip" do
      forecast = Services::Hub.new.get_forecast_for_zip(valid_zip)
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

    it "returns location for a zip" do
      forecast = Services::Hub.new.get_forecast_for_zip(valid_zip)
      validate_location(forecast.location)
    end

    context "when cache is enabled" do
      let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

      before do
        allow(Rails).to receive(:cache).and_return(memory_store)
        Rails.cache.clear
      end

      after do
        Rails.cache.clear
      end

      it "returns from cache" do
        expect(Rails.cache.exist?("forecast_for_zip:#{valid_zip}")).to eq false
        result = Services::Hub.new.get_forecast_for_zip(valid_zip)
        expect(result.from_cache).to eq false

        expect(Rails.cache.exist?("forecast_for_zip:#{valid_zip}")).to eq true
        result = Services::Hub.new.get_forecast_for_zip(valid_zip)
        expect(result.from_cache).to eq true
      end
    end
  end

  def validate_location(location)
    expect(location).to be_a(Location)
    expect(location.zip).to eq "98103"
    expect(location.lat).to eq 47.6733
    expect(location.lon).to eq -122.3426
    expect(location.name).to eq "Seattle"
    expect(location.country).to eq "US"
  end
end
