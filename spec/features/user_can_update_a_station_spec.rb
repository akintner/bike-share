require_relative '../spec_helper'

describe "When a user updates a station's information" do
  context "from the index" do
    it "saves the new information to the database" do
      station_1 = Station.create(name: "Chicago", dock_count: 22, installation_date: "March 3, 2001")
      station_2 = Station.create(name: "Detroit", dock_count: 11, installation_date: "March 6, 2001")

      visit '/stations'
      within '#station_' + "#{station_2.id}" do
        click_on "Update"
      end

      expect(page).to have_current_path "/stations/#{station_2.id}/edit"
      expect(find_field('station[name]').value).to eq 'Detroit'
      expect(find_field('station[dock_count]').value).to eq "11"
      expect(find_field('station[installation_date]').value).to eq "2001-03-06"

      fill_in 'station[name]', with: "Windy City"
      fill_in 'station[dock_count]', with: 99
      fill_in 'station[installation_date]', with: 'March 13, 2010'
      click_on 'Update station'

      expect(page).to have_current_path "/stations/#{station_2.id}"
      expect(page).to have_content "Windy City"
      expect(page).to have_content "99"
      expect(page).to have_content "2010-03-13"

      expect(page).not_to have_content "Detroit"
      expect(page).not_to have_content 11
      expect(page).not_to have_content "2001-03-06"
    end
  end

  context "from the show page" do
    it "saves the new information to the database" do
      station = Station.create(name: "Chicago", dock_count: 22, installation_date: "March 3, 2001")

      visit '/stations/'+"#{station.id}"
      click_on "Update station"

      expect(page).to have_current_path "/stations/#{station.id}/edit"
      expect(find_field('station[name]').value).to eq 'Chicago'
      expect(find_field('station[dock_count]').value).to eq "22"
      expect(find_field('station[installation_date]').value).to eq "2001-03-03"

      fill_in 'station[name]', with: "Windy City"
      fill_in 'station[dock_count]', with: 99
      fill_in 'station[installation_date]', with: 'March 13, 2010'
      click_on 'Update station'

      expect(page).to have_current_path "/stations/#{station.id}"
      expect(page).to have_content "Windy City"
      expect(page).to have_content "99"
      expect(page).to have_content "2010-03-13"

      expect(page).not_to have_content "Chicago"
      expect(page).not_to have_content 22
      expect(page).not_to have_content "2001-03-03"
    end
  end

end
