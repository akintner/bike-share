require './spec/spec_helper'

describe "weater conditions analytics" do
  before do
    City.create(name: "Denver")
    City.create(name: "Portland")
    Zipcode.create(zipcode: 94107)
    Subscription.create(name: "Customer")
    Subscription.create(name: "Subscriber")
    Station.create(name: "San Jose Station", dock_count: 27, installation_date: "2013-08-06 00:00:00", city_id: 1)
    Station.create(name: "LA Civic Center", dock_count: 9, installation_date: "2013-08-05 00:00:00", city_id: 2)
    Station.create(name: "San Francisco City Center", dock_count: 7, installation_date: "2013-08-06 00:00:00", city_id: 1)
    Station.create(name: "Near the French Laundry", dock_count: 15, installation_date: "2013-08-05 00:00:00", city_id: 2)
    Station.create(name: "Inside the French Laundry, YUM", dock_count: 27, installation_date: "2013-08-06 00:00:00", city_id: 2)
    Station.create(name: "Best Ever Bike Station", dock_count: 15, installation_date: "2013-08-05 00:00:00", city_id: 1)
    Trip.create(duration: 100, start_date: "2013-08-29", start_station_id: 1, end_date: "2013-08-29", end_station_id: 2, bike_id: 20, subscription_id: 1, zipcode_id: 1, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 310, start_date: "2013-08-29", start_station_id: 2, end_date: "2013-08-29", end_station_id: 4, bike_id: 520, subscription_id: 2, zipcode_id: 1, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 105, start_date: "2013-07-30", start_station_id: 5, end_date: "2013-07-30", end_station_id: 1, bike_id: 20, subscription_id: 2, zipcode_id: 1, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 510, start_date: "2014-08-09", start_station_id: 4, end_date: "2014-08-10", end_station_id: 3, bike_id: 520, subscription_id: 1, zipcode_id: 1, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 99, start_date: "2013-01-02", start_station_id: 3, end_date: "2013-01-10", end_station_id: 5, bike_id: 520, subscription_id: 1, zipcode_id: 1, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Trip.create(duration: 277, start_date: "1992-02-11", start_station_id: 6, end_date: "1992-02-11", end_station_id: 6, bike_id: 520, subscription_id: 1, zipcode_id: 1, start_time: "2000-01-01 14:13:00", end_time: "2000-01-01 14:14:00")
    Condition.create(measurement_date: "2013-08-29", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, humidity_percent: 75, visibility_miles: 2, mean_wind_speed_mph: 0, precipitation_inches: 0.0)
    Condition.create(measurement_date: "2013-07-30", max_temperature_f: 84, mean_temperature_f: 68, min_temperature_f: 61, humidity_percent: 75, visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.4)
    Condition.create(measurement_date: "2014-08-09", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, humidity_percent: 75, visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82)
    Condition.create(measurement_date: "2013-01-02", max_temperature_f: 73, mean_temperature_f: 68, min_temperature_f: 61, humidity_percent: 75, visibility_miles: 7, mean_wind_speed_mph: 8, precipitation_inches: 1.1)
    Condition.create(measurement_date: "1992-02-11", max_temperature_f: 52, mean_temperature_f: 44, min_temperature_f: 41, humidity_percent: 75, visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3)
    Condition.create(measurement_date: "1991-01-02", max_temperature_f: 52, mean_temperature_f: 49, min_temperature_f: 47, humidity_percent: 75, visibility_miles: 7, mean_wind_speed_mph: 12, precipitation_inches: 2.3)
  end

  it "can calculate days for precipitation range" do
    expect(Condition.days_by_precip(1).earliest).to eq("date here")
    expect(Condition.days_by_precip(1).most_recent).to eq("date here")
  end

  it "can calculate days for temperature range" do
    expect(Condition.days_by_wind(6).earliest).to eq("date here")
    expect(Condition.days_by_wind(6).most_recent).to eq("date here")
  end

  it "can calculate days for wind speed range" do
    expect(Condition.days_by_temperature(68).earliest).to eq("date here")
    expect(Condition.days_by_temperature(68).most_recent).to eq("date here")
  end

  it "can calculate days for visibility range" do
    expect(Condition.days_by_visibility(6).earliest).to eq("date here")
    expect(Condition.days_by_visibility(6).most_recent).to eq("date here")
  end

  # it "can calculate rides for precipitation range" do
  # end

  # it "can calculate rides for temperature range" do
  # end

  # it "can calculate rides for wind speed range" do
  # end

  # it "can calculate rides for visibility range" do
  # end

end