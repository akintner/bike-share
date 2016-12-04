require './spec/spec_helper'

describe "City importer" do
  let(:bad)  { './spec/fixtures/bad_cities.csv' }
  let(:good) { './spec/fixtures/good_cities.csv' }

  context "unsuccessful imports" do
    it "does not import any cities" do
      expect { 
        CityImporter.new(bad).import
      }.to change { City.count }.by(0)
    end
  end

  context "successful imports" do
    it "imports all the unique cities in the csv and saves them to the database" do
      expect { 
        CityImporter.new(good).import
      }.to change { City.count }.by(5)
    end
  end
end
