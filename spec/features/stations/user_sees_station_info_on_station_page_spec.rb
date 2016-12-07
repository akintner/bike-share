require './spec/spec_helper'

describe "When a user visits station page" do
  it "they see station information" do
    Station.create(name:"Market Street",
                          dock_count: 30,
                          installation_date: "March 3, 2000"
                          )

    station = Station.find_by(name: "Market Street")
    visit "/stations/#{station.id}"
    expect(page).to have_content("#{station.name}")
  end
end
