require_relative '../spec_helper'

describe "When a user wants to delete a station" do
  it "they can delete from the index" do
    station1 = Station.create(name: "My House", dock_count: 3, installation_date: "March 3, 2000")
    station2 = Station.create(name: "Your House", dock_count: 3, installation_date: "March 3, 2000")
    visit "/stations"

    within('#station_' + "#{station2.id}") do
      click_on "Delete"
    end
    expect(page).not_to have_content(station2.name)
  end

  it "they can delete from the details page" do
    station1 = Station.create(name: "My House", dock_count: 3, installation_date: "March 3, 2000")
    visit "/stations/#{station1.id}"

    click_on "Delete"

    expect(page).to have_current_path("/stations")
    expect(page).not_to have_content(station1.name)
  end
end
