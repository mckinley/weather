require "rails_helper"

RSpec.describe Location do
  context "when valid" do
    it "has no errors" do
      location = Location.new("98103")
      location.valid?
      expect(location.errors).to be_empty
    end
  end

  context "when zip is non-numeric" do
    it "has errors" do
      location = Location.new("9810x")
      location.valid?
      expect(location.errors[:zip]).to_not be_empty
    end
  end

  context "when zip is not 5 characters" do
    it "has errors" do
      location = Location.new("9810")
      location.valid?
      expect(location.errors[:zip]).to_not be_empty
    end
  end

  context "when zip is blank" do
    it "has errors" do
      location = Location.new("")
      location.valid?
      expect(location.errors[:zip]).to_not be_empty
    end
  end

  context "when zip includes specific 9 digits" do
    it "ignores extra digits" do
      location = Location.new("98103-1234")
      location.valid?
      expect(location.errors[:zip]).to be_empty
      expect(location.zip).to eq "98103"
    end
  end
end
