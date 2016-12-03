require_relative '../../spec_helper'

describe "Creating a new city" do
  it "saves the city information to the database" do
    visit '/cities/new'

    fill_in 'city[name]', with: 'Chicago'
    click_on 'Submit'

    city = City.find_by(name: "Chicago")

    expect(page).to have_current_path "/cities/#{city.id}"
    expect(page).to have_content "Chicago"
  end
end
