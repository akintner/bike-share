require './spec/spec_helper'

describe "Station importer" do
  let(:bad)  { './spec/fixtures/bad_stations.csv' }
  let(:good) { './spec/fixtures/good_stations.csv' }

  context "unsuccessful imports" do
    it "does not import any stations" do
      expect {
        StationImporter.new(bad).import
      }.to change { Station.count }.by(0)
    end
  end

  context "successful imports" do
    it "imports all the unique stations from the csv and saves them to the database" do
      expect {
        StationImporter.new(good).import
      }.to change { Station.count }.by(10)
    end
  end
end
