require './spec/spec_helper'

describe "Station" do
  context "attributes are validated" do
    it "validates presence of name" do
        station = Station.create(dock_count: 30,
                                installation_date: "4/13/2000"
                                )
        expect(station).not_to be_valid
    end

    it "validates presence of dock_count" do
      station = Station.create(name:"Market Street",
                            installation_date: "4/13/2000"
                            )
      expect(station).not_to be_valid
    end

    it "validates dock_count is an integer" do
      station = Station.new(name: "Market Street",
                              dock_count: 1.7,
                              installation_date: "4/13/2000"
                              )
      expect(station).not_to be_valid
    end

    it "validates presence of installation_date" do
      station = Station.create(name:"Market Street",
                            dock_count: 30
                            )
      expect(station).not_to be_valid
    end
  end
end
