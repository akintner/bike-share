require_relative '../../spec_helper'

describe "When a user updates a trip's information" do
  context "from the show" do
    it "saves the new information to the database" do
      station1= Station.create(name: "Alameda",
                            dock_count: 37,
                            installation_date: "March 1, 2000"
                           )
      station2 = Station.create(name: "Union Station",
                             dock_count: 37,
                             installation_date: "March 1, 2000"
                            )
      trip = Trip.create(duration_in_seconds: 77,
                         start_date: "March 3, 2004 14:45",
                         end_date: "March 3, 2004 14:46",
                         start_station_id: station1.id,
                         end_station_id: station2.id,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 3
                        )

      visit "/trips/#{trip.id}"
      click_on 'Update trip'

      expect(page).to have_current_path "/trips/#{trip.id}/edit"
      expect(find_field('trip[duration_in_seconds]').value).to eq "77"

      fill_in "trip[duration_in_seconds]", with: "60"
      # binding.pry
      click_on "Update trip"

      expect(page).to have_current_path "/trips/#{trip.id}"
      expect(page).to have_content
      expect(page).not_to have_content 63
    end
  end

  context "from the index" do
    it "saves the new information to the database" do
      station1= Station.create(name: "Alameda",
                            dock_count: 37,
                            installation_date: "March 1, 2000"
                           )
      station2 = Station.create(name: "Union Station",
                             dock_count: 37,
                             installation_date: "March 1, 2000"
                            )
      trip_1 = Trip.create(duration_in_seconds: 60,
                         start_date: "March 3, 2004 14:45",
                         end_date: "March 3, 2004 14:46",
                         start_station_id: station1.id,
                         end_station_id: station2.id,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 3
                        )
      trip_2 = Trip.create(duration_in_seconds: 60,
                         start_date: "March 3, 2004 14:45",
                         end_date: "March 3, 2004 14:46",
                         start_station_id: station1.id,
                         end_station_id: station2.id,
                         bike_id: 37,
                         subscription_type: 2,
                         zipcode_id: 3
                        )

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
