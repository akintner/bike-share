require './spec/spec_helper'

describe "Trip importer" do
  let(:bad)   { './spec/fixtures/bad_trips.csv' }
  let(:good)  { './spec/fixtures/good_trips.csv' }

  context "unsuccessful imports" do
    it "does not import any trips" do
      expect {
        TripImporter.new(bad).import
      }.to change { Trip.count }.by(0)
    end
  end

  context "successful imports" do

    it "imports all the unique trips from csv and saves to the database" do
      city = City.create(name: "Windy City")
      station_1 = Station.create(name: "San Jose City Hall", dock_count: 11, installation_date: Date.today, city_id: city.id)
      station_2 = Station.create(name: "South Van Ness at Market", dock_count: 22, installation_date: Date.today, city_id: city.id)
      expect {
        TripImporter.new(good).import
      }.to change { Trip.count }.by(4)
    end
  end
end
