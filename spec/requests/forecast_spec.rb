require 'rails_helper'

RSpec.describe "Forecasts", type: :request, vcr: { cassette_name: "hub" } do
  it_behaves_like "address requests"

  describe "GET /" do
    it "renders with http success" do
      get "/"
      expect(response).to be_successful
    end
  end
end
