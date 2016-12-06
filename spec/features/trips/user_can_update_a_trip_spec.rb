require_relative '../../spec_helper'

describe "When a user updates a trip's information" do
  context "from the show" do
    it "saves the new information to the database" do
      trip = Trip.create(duration: 63,
                         start_date: "4/13/2000 14:40",
                         end_date: "4/13/2000 14:41",
                         bike_id: 37,
                         subscription_type: "Customer",
                         zipcode: "80109"
                         )

      visit "/trips/#{city.id}"
      click_on 'Update trip'

      expect(page).to have_current_path "/trips/#{trip.id}/edit"
      expect(find_field('trip[duration]').value).to eq 63

      fill_in "trip[duration]", with: 77
      click_on "Update trip"

      expect(page).to have_current_path "/trips/#{trip.id}"
      expect(page).to have_content 77
      expect(page).not_to have_content 63
    end
  end

  context "from the index" do
    it "saves the new information to the database" do
      trip_1 = Trip.create(duration: 63,
                           start_date: "4/13/2000 14:40",
                           end_date: "4/13/2000 14:41",
                           bike_id: 37,
                           subscription_type: "Customer",
                           zipcode: "80109"
                           )
      trip_2 = Trip.create(duration: 123,
                            start_date: "7/23/2009 18:40",
                            end_date: "7/23/2009 18:42",
                            bike_id: 77,
                            subscription_type: "Suscriber",
                            zipcode: "28173"
                          )

      visit "/trips"

      within '#trip_' + "#{trip_2.id}" do
        click_on 'Update'
      end

      expect(page).to have_current_path "/trips/#{trip_2.id}/edit"
      expect(find_field('trip[duration]').value).to eq 123

      fill_in "trip[duration]", with: 450
      click_on "Update trip"

      expect(page).to have_current_path "/trips/#{trip_2.id}"
      expect(page).to have_content 450
      expect(page).not_to have_content 123
    end
  end
end