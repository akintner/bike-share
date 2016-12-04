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

  context "relationships" do
    it "belongs to a city" do
      city = City.create(name: "Chicago")
      station = Station.create(name: "Downtown", dock_count: 12, installation_date: Date.today, city: city)

      expect(station.city.name).to eq("Chicago")
    end
  end

  context "analytics" do

    it "can find total count of stations" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")

      expect(Station.total).to eq(2)
    end

    it "can find average available bikes" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")

      expect(Station.average_available_bikes).to eq(40)
    end

    it "can find the most available bikes at station" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")
      Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000")

      expect(Station.most_bikes_available_at_station).to eq(50)
    end

    it "can find specified number of stations with most bikes" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")
      Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000")

      expect(Station.stations_with_most_bikes(2)).to eq([4,3])
    end

    it "can find specifited number of stations with fewest bikes" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")
      Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000")

      expect(Station.stations_with_fewest_bikes(2)).to eq([1,2])
    end

    it "can find fewest number of bikes at station" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")
      Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000")

      expect(Station.fewest_bikes_available_at_station).to eq(35)
    end


    it "can find most recently installed station" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")
      Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000")

      expect(Station.most_recently_installed).to eq(4)
    end

    it "can find oldest station" do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")
      Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000")

      expect(Station.oldest_station).to eq(1)
    end
  end
end
