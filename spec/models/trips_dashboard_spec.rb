require './spec/spec_helper'
require 'pry'
 
 describe "Trip" do
   context "analytics" do
     let!(:start_station) { Station.create(name: "Starter", dock_count: 11, installation_date: Date.today) }
     let!(:end_station) { Station.create(name: "Finisher", dock_count: 17, installation_date: Date.today) }
     let!(:subscription) {Subscription.create(name: "Customer")}
     let!(:subscription) {Subscription.create(name: "Subscriber")}
     
    before do 
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 560, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 363, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
    end

     it "can find total count of trips" do
      #  trip1 = Trip.new(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
      #  trip2 = Trip.new(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 0, zipcode_id: 1)

       expect(Trip.total).to eq(2)
     end
 
     it "can find average duration of a ride" do
      #  Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
      #  Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
      #  Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.average_duration_of_ride).to eq(176)
     end
 
     it "can find the longest ride" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.longest_ride).to eq(271)
     end
 
     it "can find the shortest ride" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.shortest_ride).to eq(69)
     end
 
     it "can find station with most rides starting there" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.most_rides_starting).to eq("Finisher = 3")
     end
 
     it "can find station with most rides ending there" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.most_rides_ending).to eq("Starter = 3")
     end
 
     it "can find rides per month" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "October 7, 1989", end_date: "October 7, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       
       expect(Trip.rides_per_month(9)).to eq("9 = 3")
       expect(Trip.rides_per_month(10)).to eq("10 = 1")
    end
 
    it "can find rides per year" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 2001", end_date: "September 29, 2001", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 7, 1989", end_date: "September 7, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       
       expect(Trip.rides_per_year(2001)).to eq("2001 = 1")
       expect(Trip.rides_per_year(1989)).to eq("1989 = 3")
     end
 
    it "can find most ridden bike" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       
       expect(Trip.most_ridden_bike).to eq("17")
    end
 
     it "can find least ridden bike" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 562, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.least_ridden_bike).to eq("7")
     end

     it "can find user subscription stats" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_id: 0, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 0, zipcode_id: 1)
       Trip.create(duration_in_seconds: 367, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 0, zipcode_id: 1)
 
       expect(Trip.number_customers).to eq("Customers = 3")
       expect(Trip.number_subscribers).to eq("Subscribers = 2")
       expect(Trip.user_percentage(1)).to eq(40)
       expect(Trip.user_percentage(0)).to eq(60)
     end
     
     it "can find highest trip date" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 15, 1989", end_date: "September 15, 1989", start_station_id: 1, end_station_id: 1, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       
       expect(Trip.highest_trip_date).to eq("1989-09-09")
     end
 
     it "can find lowest trip date" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 560, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 363, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.lowest_trip_date).to eq("1989-09-29")
     end

     it "can find weather on highest trip date" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 560, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 363, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.weather_on_highest_trip_date).to eq("1989-09-29") 
     end

     it "can find weather on worst trip date" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 560, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 363, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_id: 1, zipcode_id: 1)
       Trip.create(duration_in_seconds: 561, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_id: 1, zipcode_id: 1)
 
       expect(Trip.weather_on_worst_trip_date).to eq("1989-09-29")
     end

   end
 end 