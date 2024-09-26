require 'rails_helper'

RSpec.describe "Current Weather", type: :request, vcr: { cassette_name: "open_weather_service/get_current_weather_for_zip" } do
  it_behaves_like "address requests"

  describe "GET /" do
    it "renders with http success" do
      get "/"
      expect(response).to be_successful
    end
  end
end
