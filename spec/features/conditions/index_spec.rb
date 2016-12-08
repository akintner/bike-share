require_relative '../../spec_helper'

describe "Show weather conditions for all days" do
  it "lists all conditions" do
    condition_1 = Condition.create(measurement_date: Date.today,
                                max_temperature_f: 77.0,
                                mean_temperature_f: 77.0,
                                min_temperature_f: 77.0,
                                humidity_percent: 77.0,
                                visibility_miles: 77.0,
                                mean_wind_speed_mph: 77.0,
                                precipitation_inches: 77.0
                               )
    condition_2 = Condition.create(measurement_date: Date.yesterday,
                                max_temperature_f: 66.0,
                                mean_temperature_f: 66.0,
                                min_temperature_f: 66.0,
                                humidity_percent: 66.0,
                                visibility_miles: 66.0,
                                mean_wind_speed_mph: 66.0,
                                precipitation_inches: 66.0
                               )
    visit "/conditions"

    expect(page).to have_content(Date.today.strftime('%b %e, %Y'))
    expect(page).to have_content(Date.yesterday.strftime('%b %e, %Y'))
  end
end
