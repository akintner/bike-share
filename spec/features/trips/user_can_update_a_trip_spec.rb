require_relative '../../spec_helper'

describe "When a user updates a trip's information" do
  context "from the show" do


    it "saves the new information to the database" do
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

      trip = Trip.create(duration_in_seconds: 77,
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
      click_on 'Update trip'

      expect(page).to have_current_path "/trips/#{trip.id}/edit"
      expect(find_field('trip[duration_in_seconds]').value).to eq "77"

      fill_in "trip[duration_in_seconds]", with: "60"
      click_on "Update trip"

      expect(page).to have_current_path "/trips/#{trip.id}"
      expect(page).to have_content
      expect(page).not_to have_content 63
    end
  end

  context "from the index" do

    it "saves the new information to the database" do
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
      trip_2 = Trip.create(duration_in_seconds: 60,
                         start_date: "March 3, 2004 14:45",
                         end_date: "March 3, 2004 14:46",
                         start_station_id: station_1.id,
                         end_station_id: station_2.id,
                         bike_id: 37,
                         zipcode_id: 3
                        )
      trip_1.subscription = subscription
      trip_2.subscription = subscription
      trip_1.save
      trip_2.save

      visit "/trips"
      click_on('Update_' + "#{trip_2.id}")

      expect(page).to have_current_path "/trips/#{trip_2.id}/edit"
      expect(find_field('trip[duration_in_seconds]').value).to eq "60"

      fill_in "trip[duration_in_seconds]", with: 450
      click_on "Update trip"

      expect(page).to have_current_path "/trips/#{trip_2.id}"
      expect(page).to have_content 450
      expect(page).not_to have_content "60"
    end
  end
end
