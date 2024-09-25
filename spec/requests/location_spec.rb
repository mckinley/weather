require 'rails_helper'

RSpec.describe "Location", type: :request do
  before do
    @error_substring = "prevented the retrieval of weather data"
  end

  describe "GET /" do
    it "renders with http success" do
      VCR.use_cassette("open_weather_service/get_location_weather_for_zip") do
        get "/"
        expect(response).to be_successful
      end
    end
  end

  describe "GET /?zip=98103" do
    it "renders city name" do
      VCR.use_cassette("open_weather_service/get_location_weather_for_zip") do
        get "/", params: { zip: "98103" }
        expect(response.body).to include("Seattle")
      end
    end
  end

  context "when the zip is more than 5 characters" do
    describe "GET /?zip=98103-1234" do
      it "renders the city name" do
        VCR.use_cassette("open_weather_service/get_location_weather_for_zip") do
          get "/", params: { zip: "98103-1234" }
          expect(response.body).to include("Seattle")
        end
      end
    end
  end

  context "when there are errors with the zip" do
    describe "GET /?zip=00000" do
      it "renders the error message" do
        VCR.use_cassette("open_weather_service/get_location_weather_for_zip") do
          get "/", params: { zip: "00000" }
          expect(response.body).to include(@error_substring)
        end
      end
    end

    describe "GET /?zip=" do
      it "renders the error message" do
        VCR.use_cassette("open_weather_service/get_location_weather_for_zip") do
          get "/", params: { zip: "" }
          expect(response.body).to include(@error_substring)
          expect(response.body).to include(ERB::Util.html_escape("Zip can't be blank"))
        end
      end
    end
  end
end
