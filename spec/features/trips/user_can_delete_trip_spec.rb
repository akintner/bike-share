require_relative '../../spec_helper'

describe "When a user want to delete a trip" do
  context "they can delete from the show" do
    it "removes the trip from the database" do
      trip = Trip.create(duration: "63",
                         start_date: "Time.new(2002, 10, 31, 14, 40)",
                         end_date: "Time.new(2002, 10, 31, 14, 41)",
                         bike_id: "37",
                         subscription_type: "Customer",
                         zipcode: "80109"
                        )

      visit "/trips/#{trip.id}"
      click_on 'Delete'

      expect(page).to have_current_path "/trips"
      expect(page).not_to have_content "Chicago"
    end
  end

  context "they can delete from the index" do
    it "removes that trip from the database" do
      trip_1 = Trip.create(duration: "63",
                           start_date: "Time.new(2002, 10, 31, 14, 40)",
                           end_date: "Time.new(2002, 10, 31, 14, 41)",
                           bike_id: "37",
                           subscription_type: "Customer",
                           zipcode: "80109"
                          )
      trip_2 = Trip.create(duration: "123",
                           start_date: "Time.new(2002, 9, 14, 18, 20)",
                           end_date: "Time.new(2002, 9, 14, 18, 22)",
                           bike_id: "55",
                           subscription_type: "Suscriber",
                           zipcode: "28173"
                          )

      visit "/trips"
      within '#trip_' + "#{trip_1.id}" do
        click_on 'Delete'
      end

      expect(page).to have_current_path "/trips"
      expect(page).to have_content "Suscriber"
      expect(page).not_to have_content "Customer"
    end
  end
end