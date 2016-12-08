require './spec/spec_helper'
require 'pry'
 
 describe "Trip" do
   context "analytics" do
     let!(:city) {City.create(name: "Portland")}
     let!(:start_station) { Station.create(name: "Starter", dock_count: 11, installation_date: Date.today, city_id: city.id) }
     let!(:end_station) { Station.create(name: "Finisher", dock_count: 17, installation_date: Date.today, city_id: city.id) }
     let!(:subscription) {Subscription.create(name: "Customer")}
     let!(:subscription1) {Subscription.create(name: "Subscriber")}
     let!(:zipcode) {Zipcode.create(zipcode: 81647)}
     let!(:condition1) {Condition.create(measurement_date: Date.new(1989, 9, 29), max_temperature_f: 68, mean_temperature_f: 59, min_temperature_f: 53, humidity_percent: 75, visibility_miles: 2, mean_wind_speed_mph: 0, precipitation_inches: 0.2)}
     let!(:condition2) {Condition.create(measurement_date: Date.new(1989, 9, 19), max_temperature_f: 84, mean_temperature_f: 71, min_temperature_f: 61, humidity_percent: 75, visibility_miles: 15, mean_wind_speed_mph: 3, precipitation_inches: 0.0)}
     let!(:condition3) {Condition.create(measurement_date: Date.new(1989, 9, 9), max_temperature_f: 55, mean_temperature_f: 51, min_temperature_f: 48, humidity_percent: 75, visibility_miles: 6, mean_wind_speed_mph: 8, precipitation_inches: 0.82)}

     
    before do 
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 560, start_date: "October 9, 1989", end_date: "October 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 2, zipcode_id: 1)
       Trip.create(duration_in_seconds: 363, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 2, zipcode_id: 1)
    end

     it "can find total count of trips" do

       expect(Trip.total).to eq(6)
     end
 
     it "can find average duration of a ride" do
 
       expect(Trip.average_duration_of_ride).to eq(335.167)
     end
 
     it "can find the longest ride" do
 
       expect(Trip.longest_ride).to eq(561)
     end
 
     it "can find the shortest ride" do
 
       expect(Trip.shortest_ride).to eq(69)
     end
 
     it "can find station with most rides starting there" do
 
       expect(Trip.most_rides_starting).to eq("Finisher = 4")
     end
 
     it "can find station with most rides ending there" do
 
       expect(Trip.most_rides_ending).to eq("Finisher = 4")
     end
 
     it "can find rides per month" do
       
       expect(Trip.rides_per_month(9)).to eq("5")
       expect(Trip.rides_per_month(10)).to eq("1")
    end
 
    it "can find rides per year" do
       
       expect(Trip.rides_per_year(2001)).to eq("0")
       expect(Trip.rides_per_year(1989)).to eq("6")
     end
 
    it "can find most ridden bike" do
       
       expect(Trip.most_ridden_bike).to eq("17")
    end
 
     it "can find least ridden bike" do
 
       expect(Trip.least_ridden_bike).to eq("7")
     end

     it "can find user subscription stats" do
       expect(Trip.number_customers).to eq("Customers = 4")
       expect(Trip.number_subscribers).to eq("Subscribers = 2")
       expect(Trip.user_percentage).to eq("Customer Percentage: 67.0 and Subscriber Percentage: 33.0")
     end
     
     it "can find highest trip date" do
       
       expect(Trip.show_highest_trip_date).to eq("Sep 19, 1989")
     end
 
     it "can find lowest trip date" do
 
       expect(Trip.show_lowest_trip_date).to eq("Sep 09, 1989")
     end

     it "can find weather on best trip date" do
 
       expect(Trip.weather_on_highest_trip_date).to eq("Mean Temp in F: 71.0") 
     end

     it "can find weather on worst trip date" do
 
       expect(Trip.weather_on_worst_trip_date).to eq("Precipitation in Inches: 0.82")
     end

   end
 end 