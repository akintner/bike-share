require_relative '../../spec_helper'

describe "Creating a new trip" do
  it "saves the trip information to the database" do
    visit '/trips/new'

    fill_in 'duration', with: 63
    fill_in 'start date', with: "Time.new(2002, 10, 31, 14, 20)"
    fill_in 'end date', with: "Time.new(2002, 10, 31, 14, 21)"
    fill_in 'start station', with: 4
    fill_in 'end station', with: 3
    fill_in 'bike ID', with: 36
    fill_in 'subscription type', with: 2
    fill_in 'zipcode', with: 17

    click_on 'Submit'

    trip = Trip.find_by(bike_id: 36)

    expect(page).to have_current_path "/trips/#{trip.id}"
    expect(page).to have_content 456
    expect(page).to have_content "8/29/2013 14:13"
    expect(page).to have_content "8/29/2013 14:20"
    expect(page).to have_content 4
    expect(page).to have_content "8/29/2013 14:20"
    expect(page).to have_content 36
    expect(page).to have_content "Customer"
    expect(page).to have_content 17

  end
end
