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

  context "relationships" do
    let(:today)     { Date.today }
    let(:yesterday) { Date.yesterday }

    it "has many stations" do
      station_1 = Station.create(name: "Downtown", dock_count: 12, installation_date: today)
      station_2 = Station.create(name: "Uptown", dock_count: 22, installation_date: yesterday)
      city = City.create(name: "Chicago")

      city.stations << station_1
      city.stations << station_2

      expect(city.stations.count). to eq(2)
      expect(city.stations.include?(station_1)).to be true
      expect(city.stations.include?(station_2)).to be true
    end
  end
end
