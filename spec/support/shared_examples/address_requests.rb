RSpec.shared_examples "address requests" do
  let(:valid_zip) { "98103" }
  let(:error_substring) { "prevented the retrieval of weather data" }

  describe "GET /?zip=98103" do
    it "renders city name" do
      get "/", params: { zip: valid_zip }
      expect(response.body).to include("Seattle")
    end
  end

  context "when the zip is more than 5 characters" do
    describe "GET /?zip=98103-1234" do
      it "renders the city name" do
        get "/", params: { zip: "#{valid_zip}-1234" }
        expect(response.body).to include("Seattle")
      end
    end
  end

  context "when there are errors with the zip" do
    describe "GET /?zip=00000" do
      it "renders the error message" do
        get "/", params: { zip: "00000" }
        expect(response.body).to include(error_substring)
      end
    end

    describe "GET /?zip=" do
      it "renders the error message" do
        get "/", params: { zip: "" }
        expect(response.body).to include(error_substring)
        expect(response.body).to include(ERB::Util.html_escape("Zip can't be blank"))
      end
    end
  end
end
