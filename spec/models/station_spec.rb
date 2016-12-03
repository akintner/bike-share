require './spec/spec_helper'

describe "Station" do
  context "attributes are validated" do
    it "validates presence of name" do
        station = Station.create(dock_count: 30,
                                city: "San Francicso",
                                installation_date: "4/13/2000"
                                )
        expect(station).not_to be_valid
    end

    it "validates presence of dock_count" do
      station = Station.create(name:"Market Street",
                            city: "San Francicso",
                            installation_date: "4/13/2000"
                            )
      expect(station).to be_invalid
    end

    it "validates presence of city" do
      station = Station.create(name:"Market Street",
                            dock_count: 30,
                            installation_date: "4/13/2000"
                            )
      expect(station).to be_invalid
    end

    it "validates presence of installation_date" do
      station = Station.create(name:"Market Street",
                            dock_count: 30,
                            city: "San Francicso",
                            )
      expect(station).to be_invalid
    end
  end
end
