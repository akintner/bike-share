require_relative '../../spec_helper'

describe "When a user updates a city's information" do
  context "from the show" do
    it "saves the new information to the database" do
      city = City.create(name: "Chicago")

      visit "/cities/#{city.id}"
      click_on 'Update city'

      expect(page).to have_current_path "/cities/#{city.id}/edit"
      expect(find_field('city[name]').value).to eq 'Chicago'

      fill_in "city[name]", with: "Windy City"
      click_on "Update city"

      expect(page).to have_current_path "/cities/#{city.id}"
      expect(page).to have_content "Windy City"
      expect(page).not_to have_content "Chicago"
    end
  end

  context "from the index" do
    it "saves the new information to the database" do
      city_1 = City.create(name: "Chicago")
      city_2 = City.create(name: "Detroit")

      visit "/cities"

      within '#city_' + "#{city_2.id}" do
        click_on 'Update'
      end

      expect(page).to have_current_path "/cities/#{city_2.id}/edit"
      expect(find_field('city[name]').value).to eq 'Detroit'

      fill_in "city[name]", with: "Windy City"
      click_on "Update city"

      expect(page).to have_current_path "/cities/#{city_2.id}"
      expect(page).to have_content "Windy City"
      expect(page).not_to have_content "Detroit"
    end
  end
end
