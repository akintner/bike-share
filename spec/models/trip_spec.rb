require './spec/spec_helper'

describe "Trip" do

  context "attributes are validated" do
    let(:station_1) { Station.create(name: "Alameda",
                                  dock_count: 37,
                                  installation_date: "March 3, 2003"
                                 )}
    let(:station_2) { Station.create(name: "Union Station",
                                  dock_count: 37,
                                  installation_date: "March 3, 2003"
                                 )}
    let(:subscription)  { Subscription.create(name: "Customer") }

    it "validates presence of duration" do
      trip = Trip.new(start_date: Time.now,
                         end_date: Time.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         zipcode_id: 3
                         )
      trip.subscription = subscription
      trip.save

      expect(trip).not_to be_valid
    end

     it "validates duration is an integer" do
      trip = Trip.new(duration_in_seconds: 60.2,
                            start_date: Time.now,
                            end_date: Time.now,
                            start_station_id: 1,
                            end_station_id: 2,
                            bike_id: 37,
                            zipcode_id: 3
                            )
      trip.subscription = subscription
      trip.save
      expect(trip).not_to be_valid
    end

    it "validates presence of start date" do
      trip = Trip.new(duration_in_seconds: 60,
                         end_date: Time.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         zipcode_id: 3
                        )

      trip.subscription = subscription
      trip.save
      expect(trip).not_to be_valid
    end

    it "validates presence of end date" do
      trip = Trip.new(duration_in_seconds: 60,
                         start_date: Time.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         zipcode_id: 3
                        )
      trip.subscription = subscription
      trip.save

      expect(trip).not_to be_valid
    end

    it "validates presence of start station " do
     trip = Trip.new(duration_in_seconds: 60,
                           start_date: Time.now,
                           end_date: Time.now,
                           end_station_id: 2,
                           bike_id: 37,
                           zipcode_id: 3
                          )
      trip.subscription = subscription
      trip.save
     expect(trip).not_to be_valid
    end

    it "validates presence of end station " do
     trip = Trip.new(duration_in_seconds: 60,
                           start_date: Time.now,
                           end_date: Time.now,
                           start_station_id: 1,
                           bike_id: 37,
                           zipcode_id: 3
                          )
      trip.subscription = subscription
      trip.save
     expect(trip).not_to be_valid
    end

    it "validates presence of bike id" do
      trip = Trip.new(duration_in_seconds: 60,
                      start_date: Time.now,
                      end_date: Time.now,
                      start_station_id: 1,
                      end_station_id: 2,
                      zipcode_id: 3
                     )

      trip.subscription = subscription
      trip.save
      expect(trip).not_to be_valid
    end

    it "validates presence of subscription type" do
      trip = Trip.new(duration_in_seconds: 60,
                      start_date: Time.now,
                      end_date: Time.now,
                      start_station_id: 1,
                      end_station_id: 2,
                      bike_id: 37,
                      zipcode_id: 3
                     )
      trip.subscription = subscription
      trip.save

      expect(trip).not_to be_valid
    end

     it "validates presence of zipcode" do
      trip = Trip.new(duration_in_seconds: 60,
                      start_date: Time.now,
                      end_date: Time.now,
                      start_station_id: 1,
                      end_station_id: 2,
                      bike_id: 37,
                      zipcode_id: 3
                     )

      trip.subscription = subscription
      trip.save
      expect(trip).not_to be_valid
    end

    it "validates valid trip" do
      trip = Trip.create(duration_in_seconds: 60,
                      start_date: Time.now,
                      end_date: Time.now,
                      bike_id: 37,
                      zipcode_id: 3
                     )
      trip.subscription = subscription
      trip.start_station = station_1
      trip.end_station = station_2
      trip.save
      expect(trip).to be_valid
    end

  end

  context "#subscription_name" do
    let!(:station) { Station.create(name: "Union Station",
                                  dock_count: 37,
                                  installation_date: "March 3, 2003"
                                 )}
    let!(:subscription) { Subscription.create(name: "Subscriber") }

    let(:trip) { Trip.create(duration_in_seconds: 60,
                    start_date: Time.now,
                    end_date: Time.now,
                    bike_id: 37,
                    zipcode_id: 3
                   )}
    it "returns the name of the subscription" do
      trip.subscription = subscription
      trip.start_station = station
      trip.end_station = station
      trip.save

      expect(trip.subscription_name).to eq "Subscriber"
    end
  end
end
