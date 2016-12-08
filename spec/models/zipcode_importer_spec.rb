require './spec/spec_helper'

describe "Zipcode Importer" do
  let(:bad)   { './spec/fixtures/bad_trips.csv' }
  let(:good)  { './spec/fixtures/good_trips.csv' }

  context "unsuccessful imports" do
    it "does not import any zipcodes" do
      expect {
        ZipcodeImporter.new(bad).import
      }.to change { Zipcode.count }.by(0)
    end
  end

  context "successful imports" do
    it "imports all the unique zipcodes in the csv and saves to database" do
      expect {
        ZipcodeImporter.new(good).import
      }.to change { Zipcode.count}.by(7)
    end
  end
end
