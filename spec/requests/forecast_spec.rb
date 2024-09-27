require 'rails_helper'

RSpec.describe "Forecasts", type: :request, vcr: { cassette_name: "hub" } do
  it_behaves_like "address requests"

  describe "GET /" do
    it "renders with http success" do
      get "/"
      expect(response).to be_successful
    end
  end

  describe "GET /?zip=98103" do
    it "renders current weather" do
      get "/?zip=98103"
      expect(response.body).to include("Seattle")
      expect(response.body).to include("Clouds")
      expect(response.body).to include("overcast clouds")
    end
  end
end
