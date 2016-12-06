require_relative '../../spec_helper'

describe "Creating a new trip" do

  it "saves the trip information to the database" do
    station1= Station.create(name: "Alameda",
                          dock_count: 37,
                          installation_date: "March 1, 2000"
                         )
    station2 = Station.create(name: "Union Station",
                           dock_count: 37,
                           installation_date: "March 1, 2000"
                          )
    visit '/trips/new'

    fill_in 'duration', with: 63
    fill_in 'start date', with: "March 3, 2004 14:45"
    fill_in 'end date', with: "March 3, 2004 14:46"
    fill_in 'start station', with: station1.id
    fill_in 'end station', with: station2.id
    fill_in 'bike ID', with: 36
    fill_in 'subscription type', with: 2
    fill_in 'zipcode', with: 17

    click_on 'Submit'

    trip = Trip.find_by(bike_id: 36)

    expect(page).to have_current_path "/trips/#{trip.id}"
    expect(page).to have_content 63
    expect(page).to have_content "2004-03-03 14:45 "
    expect(page).to have_content "2004-03-03 14:46"
    expect(page).to have_content 1
    expect(page).to have_content 2
    expect(page).to have_content 36
    expect(page).to have_content 2
    expect(page).to have_content 17

  end
end
