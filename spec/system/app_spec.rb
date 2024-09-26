require 'rails_helper'

RSpec.describe "App", type: :system, vcr: { cassette_name: "hub", allow_playback_repeats: true } do
  before do
    driven_by(:rack_test)
  end

  it "renders current weather and forecast" do
    visit "/"
    expect(page.find("h1")).to have_text("Current Weather")
    fill_in "zip", with: "98103"
    click_button "Get Weather"

    expect(page).to have_text("Seattle")
    click_link "Forecast"

    expect(page.find("h1")).to have_text("Forecast")
    expect(page).to have_text("Seattle")
    click_link "Current Weather"

    expect(page.find("h1")).to have_text("Current Weather")
    expect(page).to have_text("Seattle")
    click_link "Home"

    expect(page.find("h1")).to have_text("Current Weather")
    expect(page).to_not have_text("Seattle")
  end
end
