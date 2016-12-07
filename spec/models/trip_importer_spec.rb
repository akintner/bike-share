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
      expect {
        TripImporter.new(good).import
      }.to change { Trip.count }.by(9)
    end
  end
end
