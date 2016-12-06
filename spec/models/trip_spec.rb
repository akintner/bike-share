require './spec/spec_helper'

describe "Trip" do
  context "attributes are validated" do
    let(:trip_1) { Station.create(name: "Alameda",
                                  dock_count: 37,
                                  installation_date: "March 3, 2003"
                                 )}
    let(:trip_2) { Station.create(name: "Union Station",
                                  dock_count: 37,
                                  installation_date: "March 3, 2003"
                                 )}

    it "validates presence of duration" do
      trip = Trip.create(start_date: Time.now,
                         end_date: Time.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 3
                         )

      expect(trip).not_to be_valid
    end

     it "validates duration is an integer" do
      trip = Trip.new(duration_in_seconds: 60.2,
                            start_date: Time.now,
                            end_date: Time.now,
                            start_station_id: 1,
                            end_station_id: 2,
                            bike_id: 37,
                            subscription_type: 2,
                            zipcode_id: 3
                            )
      expect(trip).not_to be_valid
    end

    it "validates presence of start date" do
      trip = Trip.create(duration_in_seconds: 60,
                         end_date: Time.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 3
                        )

      expect(trip).not_to be_valid
    end

    it "validates presence of end date" do
      trip = Trip.create(duration_in_seconds: 60,
                         start_date: Time.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 3
                        )

      expect(trip).not_to be_valid
    end

    it "validates presence of start station " do
     trip = Trip.new(duration_in_seconds: 60,
                           start_date: Time.now,
                           end_date: Time.now,
                           end_station_id: 2,
                           bike_id: 37,
                           subscription_type: 2,
                           zipcode_id: 3
                          )
     expect(trip).not_to be_valid
    end

    it "validates presence of end station " do
     trip = Trip.new(duration_in_seconds: 60,
                           start_date: Time.now,
                           end_date: Time.now,
                           start_station_id: 1,
                           bike_id: 37,
                           subscription_type: 2,
                           zipcode_id: 3
                          )
     expect(trip).not_to be_valid
    end

    it "validates presence of bike id" do
      trip = Trip.new(duration_in_seconds: 60,
                      start_date: Time.now,
                      end_date: Time.now,
                      start_station_id: 1,
                      end_station_id: 2,
                      subscription_type: 2,
                      zipcode_id: 3
                     )

      expect(trip).not_to be_valid
    end

    it "validates presence of subscription type" do
      trip = Trip.new(duration_in_seconds: 60,
                      start_date: Time.now,
                      end_date: Time.now,
                      start_station_id: 1,
                      end_station_id: 2,
                      bike_id: 37,
                      subscription_type: 2,
                      zipcode_id: 3
                     )

      expect(trip).not_to be_valid
    end

     it "validates presence of zipcode" do
      trip = Trip.new(duration_in_seconds: 60,
                      start_date: Time.now,
                      end_date: Time.now,
                      start_station_id: 1,
                      end_station_id: 2,
                      bike_id: 37,
                      subscription_type: 2,
                      zipcode_id: 3
                     )

      expect(trip).not_to be_valid
    end

  end
end
