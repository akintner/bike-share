require './spec/spec_helper'

describe "Updating weather conditions" do
  let(:today)               { Date.today }
  let(:today_formatted)     { Date.today.strftime('%Y-%m-%d') }
  let(:yesterday)           { Date.yesterday }
  let(:yesterday_formatted) { Date.yesterday.strftime('%Y-%m-%d') }
  let(:tomorrow)            { Date.tomorrow  }
  let(:tomorrow_formatted)  { Date.tomorrow.strftime('%Y-%m-%d') }
  let!(:condition_1) { Condition.create(measurement_date: today,
                                        max_temperature_f: 79.0,
                                        mean_temperature_f: 78.0,
                                        min_temperature_f: 77.0,
                                        humidity_percent: 76.0,
                                        visibility_miles: 75.0,
                                        mean_wind_speed_mph: 74.0,
                                        precipitation_inches: 73.0
                                       ) }
  let!(:condition_2) { Condition.create(measurement_date: yesterday,
                                        max_temperature_f: 69.0,
                                        mean_temperature_f: 68.0,
                                        min_temperature_f: 67.0,
                                        humidity_percent: 66.0,
                                        visibility_miles: 65.0,
                                        mean_wind_speed_mph: 64.0,
                                        precipitation_inches: 63.0
                                       ) }

  context "from the index page" do
    it "updates the information in the database" do
      visit '/conditions'
      within '#condition_' + "#{condition_2.id}" do
        click_on "Update"
      end

      expect(page).to have_current_path("/conditions/#{condition_2.id}/edit")
      expect(find_field('condition[measurement_date]').value).to eq yesterday_formatted
      expect(find_field('condition[max_temperature_f]').value).to eq '69.0'
      expect(find_field('condition[mean_temperature_f]').value).to eq '68.0'
      expect(find_field('condition[min_temperature_f]').value).to eq '67.0'
      expect(find_field('condition[humidity_percent]').value).to eq '66.0'
      expect(find_field('condition[visibility_miles]').value).to eq '65.0'
      expect(find_field('condition[mean_wind_speed_mph]').value).to eq '64.0'
      expect(find_field('condition[precipitation_inches]').value).to eq '63.0'

      fill_in 'condition[measurement_date]', with: tomorrow
      fill_in 'condition[max_temperature_f]', with: 101
      fill_in 'condition[mean_temperature_f]', with: 102
      fill_in 'condition[min_temperature_f]', with: 103
      fill_in 'condition[humidity_percent]', with: 104
      fill_in 'condition[visibility_miles]', with: 105
      fill_in 'condition[mean_wind_speed_mph]', with: 106
      fill_in 'condition[precipitation_inches]', with: 107
      click_on 'Update weather conditions'

      expect(page).to have_current_path("/conditions/#{condition_2.id}")
      expect(page).to have_content tomorrow_formatted
      expect(page).to have_content 101
      expect(page).to have_content 102
      expect(page).to have_content 103
      expect(page).to have_content 104
      expect(page).to have_content 105
      expect(page).to have_content 106
      expect(page).to have_content 107

      expect(page).not_to have_content today_formatted
    end
  end

  context "from the show page" do
    it "updates the information in the database" do
      visit "/conditions/#{condition_2.id}"
      click_on "Update weather conditions"

      expect(page).to have_current_path("/conditions/#{condition_2.id}/edit")
      expect(find_field('condition[measurement_date]').value).to eq yesterday_formatted
      expect(find_field('condition[max_temperature_f]').value).to eq '69.0'
      expect(find_field('condition[mean_temperature_f]').value).to eq '68.0'
      expect(find_field('condition[min_temperature_f]').value).to eq '67.0'
      expect(find_field('condition[humidity_percent]').value).to eq '66.0'
      expect(find_field('condition[visibility_miles]').value).to eq '65.0'
      expect(find_field('condition[mean_wind_speed_mph]').value).to eq '64.0'
      expect(find_field('condition[precipitation_inches]').value).to eq '63.0'

      fill_in 'condition[measurement_date]', with: tomorrow
      fill_in 'condition[max_temperature_f]', with: 101
      fill_in 'condition[mean_temperature_f]', with: 102
      fill_in 'condition[min_temperature_f]', with: 103
      fill_in 'condition[humidity_percent]', with: 104
      fill_in 'condition[visibility_miles]', with: 105
      fill_in 'condition[mean_wind_speed_mph]', with: 106
      fill_in 'condition[precipitation_inches]', with: 107
      click_on 'Update weather conditions'

      expect(page).to have_current_path("/conditions/#{condition_2.id}")
      expect(page).to have_content tomorrow_formatted
      expect(page).to have_content 101
      expect(page).to have_content 102
      expect(page).to have_content 103
      expect(page).to have_content 104
      expect(page).to have_content 105
      expect(page).to have_content 106
      expect(page).to have_content 107

      expect(page).not_to have_content today_formatted
    end
  end

end

