require './spec/spec_helper'

describe "Condition importer" do
  let(:bad)   { './spec/fixtures/bad_stations.csv' }
  let(:good)  { './spec/fixtures/good_stations.csv'}

  context "unsuccessful imports" do
    it "does not import any conditions" do
      expect {
        ConditionImporter.new(bad).import
      }.to change { Condition.count }.by(0)
    end
  end

  context "successful imports" do
    it "imports all the unique conditions from the csv and saves to database" do
      expect {
        ConditionImporter.new(good).import
      }.to change { Condition.count }.by(0)
    end
  end
end
