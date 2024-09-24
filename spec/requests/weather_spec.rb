require 'rails_helper'

RSpec.describe "Weather", type: :request do
  describe "GET /" do
    it "returns http success" do
      VCR.use_cassette("open_weather_service/get_weather") do
        get "/"
        expect(response).to have_http_status(:success)
      end
    end
  end
end
