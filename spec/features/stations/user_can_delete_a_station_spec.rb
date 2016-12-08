require './spec/spec_helper'

describe "When a user wants to delete a station" do
  let!(:city) { City.create(name: "Windy City") }

  it "they can delete from the index" do
    station1 = Station.create(name: "My House", dock_count: 3, installation_date: "March 3, 2000", city_id: city.id)
    station2 = Station.create(name: "Your House", dock_count: 3, installation_date: "March 3, 2000", city_id: city.id)
    visit "/stations"

    within('#station_' + "#{station2.id}") do
      click_on "Delete"
    end
    expect(page).not_to have_content(station2.name)
  end

  it "they can delete from the details page" do
    station1 = Station.create(name: "My House", dock_count: 3, installation_date: "March 3, 2000", city_id: city.id)
    visit "/stations/#{station1.id}"

    click_on "Delete"

    expect(page).to have_current_path("/stations/?page=1")
    expect(page).not_to have_content(station1.name)
  end
end
