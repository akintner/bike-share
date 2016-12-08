require_relative '../../spec_helper'

describe "When a user want to delete a trip" do
  context "they can delete from the show" do
    it "removes the trip from the database" do
      city = City.create(name: "Boston")
      station_1 = Station.create(name: "Alameda",
                                 dock_count: 37,
                                 installation_date: "March 3, 2003"
                                )
      station_2 = Station.create(name: "Union Station",
                                 dock_count: 37,
                                 installation_date: "March 3, 2003"
                                )
      station_1.city = city
      station_2.city = city
      station_1.save
      station_2.save
      subscription = Subscription.create(name: "Customer")

      trip = Trip.create(duration_in_seconds: 60,
                         start_date: "March 3, 2004 14:45",
                         end_date: "March 3, 2004 14:46",
                         start_station_id: station_1.id,
                         end_station_id: station_2.id,
                         bike_id: 37,
                         zipcode_id: 3
                        )
      trip.subscription = subscription
      trip.save
      visit "/trips/#{trip.id}"
      click_on "Delete"

      expect(page).to have_current_path "/trips/?page=1"
      expect(page).not_to have_content "60"
    end
  end

  context "they can delete from the index" do

    it "removes that trip from the database" do
      city = City.create(name: "Boston")
      station_1 = Station.create(name: "Alameda",
                                 dock_count: 37,
                                 installation_date: "March 3, 2003"
                                )
      station_2 = Station.create(name: "Union Station",
                                 dock_count: 37,
                                 installation_date: "March 3, 2003"
                                )
      station_1.city = city
      station_2.city = city
      station_1.save
      station_2.save

      subscription = Subscription.create(name: "Customer")

      trip_1 = Trip.create(duration_in_seconds: 60,
                           start_date: "March 3, 2004 14:45",
                           end_date: "March 3, 2004 14:46",
                           start_station_id: station_1.id,
                           end_station_id: station_2.id,
                           bike_id: 37,
                           zipcode_id: 3
                          )

      trip_2 = Trip.create(duration_in_seconds: 120,
                           start_date: "January 3, 2004 14:45",
                           end_date: "January 3, 2004 14:46",
                           start_station_id: station_1.id,
                           end_station_id: station_2.id,
                           bike_id: 59,
                           zipcode_id: 3
                          )
      trip_1.subscription = subscription
      trip_2.subscription = subscription
      trip_1.save
      trip_2.save
      visit "/trips"
      # save_and_open_page
      within('#trip_' + "#{trip_2.id}") do
        click_on("Delete")
      end

      expect(page).to have_current_path "/trips/?page=1"
      expect(page).to have_content 60
      expect(page).not_to have_content 120
    end
  end
end
