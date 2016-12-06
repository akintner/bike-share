require_relative '../../spec_helper'

describe "When a user want to delete a trip" do
  context "they can delete from the show" do
    it "removes the trip from the database" do
      trip = Trip.create(duration_in_seconds: 60,
                         start_date: Time.now,
                         end_date: Time.now,
                         start_station_id: 1,
                         end_station_id: 2,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 3
                        )

      visit "/trips/#{trip.id}"
      click_on 'Delete'

      expect(page).to have_current_path "/trips"
      expect(page).not_to have_content "60"
    end
  end

  context "they can delete from the index" do
    it "removes that trip from the database" do
      trip_1 = Trip.create(duration_in_seconds: 60,
                           start_date: Time.now,
                           end_date: Time.now,
                           start_station_id: 1,
                           end_station_id: 2,
                           bike_id: 37,
                           subscription_type: 2,
                           zipcode_id: 3
                          )

      trip_2 = Trip.create(duration_in_seconds: 120,
                           start_date: Time.now,
                           end_date: Time.now,
                           start_station_id: 4,
                           end_station_id: 6,
                           bike_id: 59,
                           subscription_type: 2,
                           zipcode_id: 3
                          )

      visit "/trips"
      within "/trips/#{trip_2.id}" do
        click_on 'Delete'
      end

      expect(page).to have_current_path "/trips"
      expect(page).to have_content 60
      expect(page).not_to have_content 120
    end
  end
end
