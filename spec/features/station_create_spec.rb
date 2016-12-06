require_relative '../spec_helper'

describe "Creates a station" do
  let(:today) {DateTime.now}

  it "saves the station's data to the database" do
    visit '/stations/new'

    fill_in "station[name]", with: "Union Station"
    fill_in "station[dock_number]", with: 12
    fill_in "station[city]", with: "San Jose"
    fill_in "station[installation_date]", with: today
    click_on'Create Station'

    expect(page).to have_content 'Union Station'
    expect(page).to have_content 12
    expect(page).to have_content 'Chicago'
  end
end
