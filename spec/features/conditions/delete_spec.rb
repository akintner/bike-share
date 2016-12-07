require_relative '../../spec_helper'

describe "When a user wants to delete the weather conditions for a day" do

  context "they can delete from the show" do
    let(:today) { Date.today }
    let(:today_formatted) { Date.today.strftime("%Y/%m/%d") }
    let(:yesterday) { Date.yesterday }
    let!(:yesterday_formatted) { Date.yesterday.strftime("%Y/%m/%d") }
    let!(:condition_1) { Condition.create(measurement_date: today,
                                          max_temperature_f: 77.0,
                                          mean_temperature_f: 77.0,
                                          min_temperature_f: 77.0,
                                          humidity_percent: 77.0,
                                          visibility_miles: 77.0,
                                          mean_wind_speed_mph: 77.0,
                                          precipitation_inches: 77.0
                                         ) }
    let!(:condition_2) { Condition.create(measurement_date: yesterday,
                                         max_temperature_f: 66.0,
                                         mean_temperature_f: 66.0,
                                         min_temperature_f: 66.0,
                                         humidity_percent: 66.0,
                                         visibility_miles: 66.0,
                                         mean_wind_speed_mph: 66.0,
                                         precipitation_inches: 66.0
                                        ) }
    it "removes the weather conditons for that day from the database" do
      visit "/conditions/#{condition_1.id}"
      click_on 'Delete'

      expect(page).to have_current_path('/conditions')
      expect(page).not_to have_content(today_formatted)
    end
  end

  context "they can delete from the index" do
    let(:today) { Date.today }
    let(:today_formatted) { Date.today.strftime("%Y/%m/%d") }
    let(:yesterday) { Date.yesterday }
    let!(:yesterday_formatted) { Date.yesterday.strftime("%Y/%m/%d") }
    let!(:condition_1) { Condition.create(measurement_date: today,
                                          max_temperature_f: 77.0,
                                          mean_temperature_f: 77.0,
                                          min_temperature_f: 77.0,
                                          humidity_percent: 77.0,
                                          visibility_miles: 77.0,
                                          mean_wind_speed_mph: 77.0,
                                          precipitation_inches: 77.0
                                         ) }
    let!(:condition_2) { Condition.create(measurement_date: yesterday,
                                         max_temperature_f: 66.0,
                                         mean_temperature_f: 66.0,
                                         min_temperature_f: 66.0,
                                         humidity_percent: 66.0,
                                         visibility_miles: 66.0,
                                         mean_wind_speed_mph: 66.0,
                                         precipitation_inches: 66.0
                                        ) }
    it "removes the weather conditons for that day from the database" do
      visit "/conditions"
      within '#condition_' + "#{condition_2.id}" do
        click_on 'Delete'
      end

      expect(page).to have_current_path('/conditions')
      expect(page).not_to have_content(yesterday_formatted)
    end
  end
end
