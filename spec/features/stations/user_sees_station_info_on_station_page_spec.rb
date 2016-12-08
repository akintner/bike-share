require './spec/spec_helper'

describe "When a user visits station page" do
    let!(:city) { City.create(name: "Windy City") }

  it "they see station information" do
    station_1 = Station.create(name:"Market Street",
                   dock_count: 30,
                   installation_date: "March 3, 2000",
                   city_id: city.id
                  )

    station = Station.find_by(name: "Market Street")
    visit "/stations/#{station.id}"
    expect(page).to have_content("#{station.name}")
  end
end
