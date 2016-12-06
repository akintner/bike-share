require_relative '../../spec_helper'

describe "Creating a new trip" do
  it "saves the trip information to the database" do
    visit '/trip/new'

    fill_in 'trip[duration]', with: "63"
    fill_in 'trip[start_date]', with: "Time.new(2002, 10, 31, 14, 20)"
    fill_in 'trip[end_date]', with: "Time.new(2002, 10, 31, 14, 21)"
    fill_in 'trip[bike_id]', with: "36"
    fill_in 'trip[subscription_type]', with: "Customer"
    fill_in 'trip[zipcode]', with: '94502'

    click_on 'Submit'

    trip = Trip.find_by(name: "Chicago")

    expect(page).to have_current_path "/trips/#{trip.id}"
    expect(page).to have_content 456
    expect(page).to have_content "8/29/2013 14:13"
    expect(page).to have_content "8/29/2013 14:20"
    expect(page).to have_content 36
    expect(page).to have_content "Customer"
    expect(page).to have_content '94502'

  end
end