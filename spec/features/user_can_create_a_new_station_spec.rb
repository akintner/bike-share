require_relative '../spec_helper'

describe "When a user visits the new station path" do
  xit "they can create a new station" do
    visit "/stations/new"

    fill_in "station[name]", with: "My House"
    fill_in "station[dock_count]", with: "1"
    fill_in "station[installation_date]", with: "March 3, 2000"
    find('datalist')
    find(:css, 'datalist').click
    find(:css, 'datalist#cities').click_on(id: "San Francisco")
    # db_type_select = find('datalist')
    # within(db_type_select) do
    #   find('.new-station-prompt input.datalist', text: 'San Francisco').click
    # end
    click_on "Submit"


    station = Station.find_by(name: "My House")
    expect(current_path).to eq("/stations/#{station.id}")
    expect(page).to have_content("My House")
    expect(page).to have_content("San Francisco")
  end
end
