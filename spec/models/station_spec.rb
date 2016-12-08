require './spec/spec_helper'

describe "Station" do
  context "attributes are validated" do
    it "validates presence of name" do
        station = Station.create(dock_count: 30,
                                installation_date: Date.today,
                                city_id: 1
                                )
        expect(station).not_to be_valid
    end

    it "validates presence of dock_count" do
      station = Station.create(name:"Market Street",
                            installation_date: Date.today,
                            city_id: 1
                            )
      expect(station).not_to be_valid
    end

    it "validates dock_count is an integer" do
      station = Station.new(name: "Market Street",
                              dock_count: 1.7,
                              installation_date: Date.today,
                              city_id: 1
                              )
      expect(station).not_to be_valid
    end

    it "validates presence of installation_date" do
      station = Station.create(name:"Market Street",
                            dock_count: 30,
                            city_id: 1
                            )
      expect(station).not_to be_valid
    end

    it "validates presence of city" do
      station = Station.create(name:"Market Street",
                               dock_count: 30,
                               installation_date: Date.today,
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
    let!(:station_1) { Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000", city_id: 1) }
    let!(:station_2) { Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000", city_id: 1) }
    let!(:station_3) { Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000", city_id: 1) }
    let!(:station_4) { Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000", city_id: 1) }


    it "can find total count of stations" do

      expect(Station.total).to eq(4)
    end

    it "can find average available bikes" do

      expect(Station.average_available_bikes).to eq(43)
    end

    it "can find the most available bikes at station" do

      expect(Station.most_bikes_available_at_station).to eq(50)
    end

    it "can find specified number of stations with most bikes" do

      expect(Station.stations_with_most_bikes(2).pluck(:id)).to eq([4,3])
    end

    it "can find specifited number of stations with fewest bikes" do

      expect(Station.stations_with_fewest_bikes(2).pluck(:id)).to eq([1,2])
    end

    it "can find fewest number of bikes at station" do

      expect(Station.fewest_bikes_available_at_station).to eq(35)
    end


    it "can find most recently installed station" do

      station_name = Station.most_recently_installed_name
      station_date = Station.most_recently_installed_date.to_s
      expect(station_name).to eq("Mission Street")
      expect(station_date).to eq("2000-03-07")
    end

    it "can find oldest station" do

      station_name = Station.oldest_station_name
      station_date = Station.oldest_station_date.to_s
      expect(station_name).to eq("Polk Street")
      expect(station_date).to eq("2000-03-04")
    end
  end

  context "Trip analytics" do
    let!(:city) { City.create(name: "Denver")}
    let!(:zipcode_1) { Zipcode.create(zipcode: 90121) }
    let!(:zipcode_2) { Zipcode.create(zipcode: 90122) }
    let!(:station_1) { Station.create(
                            name: "Mission",
                            dock_count: 30,
                            installation_date: Date.today,
                            city_id: city.id
                            )}
    let!(:station_2) { Station.create(
                            name: "Polk Street",
                            dock_count: 30,
                            installation_date: Date.today,
                            city_id: city.id
                            )}

    let!(:trip_1) { Trip.create(duration_in_seconds: 60,
                              start_date: DateTime.new(2010,9,12),
                              end_date: DateTime.new(2010,9,13),
                              start_station_id: station_1.id,
                              end_station_id: station_2.id,
                              bike_id: 37,
                              subscription_id: 1,
                              zipcode_id: zipcode_1.id)}

    let!(:trip_2) { Trip.create(duration_in_seconds: 60,
                              start_date: DateTime.new(2010,9,12),
                              end_date: DateTime.new(2010,9,13),
                              start_station_id: station_1.id,
                              end_station_id: station_2.id,
                              bike_id: 37,
                              subscription_id: 1,
                              zipcode_id: zipcode_1.id)}
    let!(:trip_3) { Trip.create(duration_in_seconds: 60,
                              start_date: DateTime.new(2010,9,11),
                              end_date: DateTime.new(2010,9,11),
                              start_station_id: station_1.id,
                              end_station_id: station_2.id,
                              bike_id: 37,
                              subscription_id: 1,
                              zipcode_id: zipcode_1.id)}

    let!(:trip_4) { Trip.create(duration_in_seconds: 60,
                              start_date: DateTime.new(2010,9,10),
                              end_date: DateTime.new(2010,9,10),
                              start_station_id: station_1.id,
                              end_station_id: station_2.id,
                              bike_id: 38,
                              subscription_id: 1,
                              zipcode_id: zipcode_2.id)}

    let!(:trip_5) { Trip.create(duration_in_seconds: 60,
                              start_date: DateTime.new(2010,9,10),
                              end_date: DateTime.new(2010,9,10),
                              start_station_id: station_2.id,
                              end_station_id: station_2.id,
                              bike_id: 38,
                              subscription_id: 1,
                              zipcode_id: zipcode_2.id)}

    it "can find number of rides started at a station" do

      expect(station_1).to be_valid
      expect(trip_1).to be_valid

      rides_1 = station_1.number_of_rides_started_at_station
      expect(rides_1).to eq(4)
    end

    it "can find number of rides end at a station" do
      rides_2 = station_2.number_of_rides_ended_at_station

      expect(rides_2).to eq(5)
    end

    it "can find the most frequent destination station" do
      expect(station_1.most_frequent_destination_station).to eq(station_2.name)
    end

    it "can find the most frequent origination station" do
      expect(station_2.most_frequent_origination_station).to eq(station_1.name)
    end

    it "can find date with highest number of trips started at station" do
      expect(station_1.date_with_most_trips).to eq("09/12/2010")
    end

    it "can find the most frequent user zipcode" do
      expect(station_1.frequent_user_zipcode).to eq(90121)
    end

    it "can find the most used bike" do
      expect(station_1.most_used_bike).to eq(37)
    end

    it "can find totatl rides for most used bike" do
      expect(station_1.most_used_bike_total_rides).to eq(3)
    end
  end
end
