require_relative '../../spec_helper'

describe "Show all cities" do
  it "lists all cities" do
    city_1 = City.create(name: "Chicago")
    city_2 = City.create(name: "Windy City")

    visit '/cities'

    expect(page).to have_content "Chicago"
    expect(page).to have_content "Windy City"
  end
end
