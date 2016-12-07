require './spec/spec_helper'

describe "When a user visits station dashboard page" do
  context "user sees dashboard information" do
    before do
      Station.create(name:"Polk Street", dock_count: 35, installation_date: "March 4, 2000")
      Station.create(name:"Valencia", dock_count: 40, installation_date: "March 5, 2000")
      Station.create(name:"California Street", dock_count: 45, installation_date: "March 6, 2000")
      Station.create(name:"Mission Street", dock_count: 50, installation_date: "March 7, 2000")
    end

    it "they see total stations" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.total}")
    end

    it "they see average docks" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.average_available_bikes}")
    end

    it "they see most number of bikes at a station" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.most_bikes_available_at_station}")
    end

    it "they see name of station with most bikes" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.find(Station.stations_with_most_bikes(1)).first.name}")
    end

    it "they see fewest bikes available at station" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.fewest_bikes_available_at_station}")
    end

    it "they see name of station with fewest bikes" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.find(Station.stations_with_fewest_bikes(1)).first.name}")
    end

    it "they see newest station" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.find(Station.most_recently_installed).name}")
    end

    it "they see newest station" do
      visit "/stations-dashboard"

      expect(page).to have_content("#{Station.find(Station.oldest_station).name}")
    end
  end
end
