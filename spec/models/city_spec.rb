require './spec/spec_helper'

describe "City" do
  context "attributes are validated" do
    it "validates presence of name" do
      city = City.new

      expect(city).not_to be_valid
    end
  end
end
