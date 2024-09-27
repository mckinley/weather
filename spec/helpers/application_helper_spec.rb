require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "format_temperature" do
    context "when the temperature is a number" do
      it "formats the temperature" do
        expect(helper.format_temperature(66.66)).to eq("67° F")
      end
    end

    context "when the temperature is a string" do
      it "formats the temperature" do
        expect(helper.format_temperature("66.66")).to eq("67° F")
      end
    end
  end
end
