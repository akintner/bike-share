require_relative '../../spec_helper'

describe "When a user want to delete a city" do
  context "they can delete from the show" do
    it "removes the city from the database" do
      city = City.create(name: "Chicago")

      visit "/cities/#{city.id}"
      click_on 'Delete'

      expect(page).to have_current_path "/cities"
      expect(page).not_to have_content "Chicago"
    end
  end

  context "they can delete from the index" do
    it "removes that city from the database" do
      city_1 = City.create(name: "Chicago")
      city_2 = City.create(name: "Windy City")

      visit "/cities"
      within '#city_' + "#{city_1.id}" do
        click_on 'Delete'
      end

      expect(page).to have_current_path "/cities"
      expect(page).to have_content "Windy City"
      expect(page).not_to have_content "Chicago"
    end
  end
end
