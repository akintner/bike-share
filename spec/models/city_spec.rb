require './spec/spec_helper'

describe "City" do
  context "attributes are validated" do
    it "validates presence of name" do
      city = City.new

      expect(city).not_to be_valid
    end

    it "validates uniqueness of name" do
      city_1 = City.create(name: "Chicago")
      city_2 = City.new(name: "Chicago")

      expect(city_2).not_to be_valid
    end
  end
end
