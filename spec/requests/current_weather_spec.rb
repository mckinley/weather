require 'rails_helper'

RSpec.describe "Current Weather", type: :request, vcr: { cassette_name: "hub" } do
  it_behaves_like "address requests"

  describe "GET /forecast" do
    it "renders with http success" do
      get "/forecast"
      expect(response).to be_successful
    end
  end

  describe "GET /forecast?zip=98103" do
    it "renders forecast" do
      get "/forecast?zip=98103"
      expect(response.body).to include("Tonight")
      expect(response.body).to include("Slight Chance Showers And Thunderstorms then Mostly Cloudy")
      expect(response.body).to include("A chance of rain before 11pm, then a slight chance of showers and thunderstorms between 11pm and midnight. Mostly cloudy, with a low around 51. Southeast wind around 6 mph. Chance of precipitation is 50%. New rainfall amounts less than a tenth of an inch possible.")
    end
  end
end
