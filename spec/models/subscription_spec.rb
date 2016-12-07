require './spec/spec_helper'

describe "Subscription" do
  context "attributes are validated" do
    it "validates presence of name" do
        subscription = Subscription.new
        expect(subscription).not_to be_valid
    end
  end

  context "relationships" do
      let(:subscription) {Subscription.create(name: "Customer")}
      let(:station_1) { Station.create(name: "Alameda",
                                       dock_count: 37,
                                       installation_date: "March 3, 2003"
                                      )}
      let(:station_2) { Station.create(name: "Union Station",
                                       dock_count: 37,
                                       installation_date: "March 3, 2003"
                                      )}
      let(:trip_1)    {Trip.new(duration_in_seconds: 63,
                                start_date: "March 3, 2002 14:45",
                                end_date: "March 3, 2002 14:46",
                                bike_id: 37,
                                zipcode_id: 3
                                )}
      let(:trip_2)    {Trip.new(duration_in_seconds: 75,
                                start_date: "March 3, 2002 14:45",
                                end_date: "March 3, 2002 14:46",
                                bike_id: 37,
                                zipcode_id: 3
                                )}
    it "has many Trips" do

      trip_1.start_station = station_1
      trip_1.end_station   = station_2
      trip_1.subscription  = subscription
      trip_2.start_station = station_2
      trip_2.end_station   = station_1
      trip_2.subscription  = subscription

      trip_1.save
      trip_2.save

      expect(subscription.trips.count). to eq(2)
      expect(subscription.trips.include?(trip_1)).to be true
      expect(subscription.trips.include?(trip_2)).to be true
    end
  end
end
