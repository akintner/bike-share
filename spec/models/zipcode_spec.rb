require './spec/spec_helper'

describe "Zipcode" do
  context "attributes are validated" do
    it "validates presence of zipcode" do
      zipcode = Zipcode.new

      expect(zipcode).not_to be_valid
    end

    it "validates uniqueness of zipcode" do
      zipcode_1 = Zipcode.create(zipcode: 94107)
      zipcode_2 = Zipcode.create(zipcode: 94107)

      expect(zipcode_2).not_to be_valid
    end
  end

  context "relationships" do
    it "has many trips" do
      zipcode_1 = Zipcode.create(zipcode: 94107)
      zipcode_2 = Zipcode.create(zipcode: 94108)

      station_1 = Station.create(name:"Polk Street",
                                dock_count: 35,
                                installation_date: "March 4, 2000",
                                city_id: 1
                                )

      station_2 = Station.create(name:"Market Street",
                                dock_count: 35,
                                installation_date: "March 5, 2000",
                                city_id: 1
                                )

      trip_1 =  Trip.create(
                         duration_in_seconds: 60,
                         start_date: DateTime.now,
                         end_date: DateTime.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 1
                         )
      trip_2 =  Trip.create(
                         duration_in_seconds: 60,
                         start_date: Date.today,
                         end_date: Date.today,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 2
                         )

      expect(zipcode_1.trips.count).to eq(1)
      expect(zipcode_2.trips.count).to eq(1)
      expect(zipcode_1.trips.include?(trip_1)).to be true
      expect(zipcode_2.trips.include?(trip_2)).to be true
    end
  end
end
