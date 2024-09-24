require 'rails_helper'

RSpec.describe "Weather", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "shows the weather" do
    visit "/"
    expect(page).to have_text("Weather")
  end
end
