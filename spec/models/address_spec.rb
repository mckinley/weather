require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:valid_zip) { "98103" }
  context "when valid" do
    it "has no errors" do
      address = Address.new(zip: valid_zip)
      address.valid?
      expect(address.errors).to be_empty
    end
  end

  context "when zip is non-numeric" do
    it "has errors" do
      address = Address.new(zip: "9810x")
      address.valid?
      expect(address.errors[:zip]).to_not be_empty
    end
  end

  context "when zip is not 5 characters" do
    it "has errors" do
      address = Address.new(zip: "9810")
      address.valid?
      expect(address.errors[:zip]).to_not be_empty
    end
  end

  context "when zip is blank" do
    it "has errors" do
      address = Address.new(zip: "")
      address.valid?
      expect(address.errors[:zip]).to_not be_empty
    end
  end

  context "when zip includes specific 9 digits" do
    it "ignores extra digits" do
      address = Address.new(zip: "#{valid_zip}-1234")
      address.valid?
      expect(address.errors[:zip]).to be_empty
      expect(address.zip).to eq valid_zip
    end
  end
end
