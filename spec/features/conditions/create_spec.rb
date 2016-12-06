require './spec/spec_helper'

describe "Entering the weather conditions for a day" do

  it "saves the conditions information to the database" do
    visit "/conditions/new"

    fill_in 'condition[measurement_date]', with: Date.today
    fill_in 'condition[max_temperature_f]', with: 74.0
    fill_in 'condition[mean_temperature_f]', with: 68.0
    fill_in 'condition[min_temperature_f]', with: 61.0
    fill_in 'condition[humidity_percent]', with: 75.0
    fill_in 'condition[visibility_miles]', with: 10.0
    fill_in 'condition[mean_wind_speed_mph]', with: 23.0
    fill_in 'condition[precipitation_inches]', with: 11.0
    click_on 'Submit'

    condition = Condition.find_by(measurement_date: Date.today)

    expect(page).to have_current_path "/conditions/#{condition.id}"
    expect(page).to have_content Date.today
    expect(page).to have_content 11.0
  end
end
