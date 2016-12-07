require './spec/spec_helper'
require 'pry'
 
 describe "Trip" do
   context "analytics" do
     let!(:start_station) { Station.create(name: "Starter", dock_count: 11, installation_date: Date.today) }
     let!(:end_station) { Station.create(name: "Finisher", dock_count: 11, installation_date: Date.today) }
 
     it "can find total count of trips" do
       trip1 = Trip.new(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       trip2 = Trip.new(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", bike_id: 17, subscription_type: "Subscriber", zipcode_id: 81420)
       trip1.start_station = start_station
       trip1.end_station = end_station
       trip2.start_station = start_station
       trip2.end_station = end_station
       trip1.save
       trip2.save

       expect(Trip.total).to eq(2)
     end
 
     it "can find average duration of a ride" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
 
       expect(Trip.average_duration_of_ride).to eq(176)
     end
 
     it "can find the longest ride" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
 
       expect(Trip.longest_ride).to eq(271)
     end
 
     it "can find the shortest ride" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
 
       expect(Trip.shortest_ride).to eq(69)
     end
 
     it "can find station with most rides starting there" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
 
       expect(Trip.most_rides_starting).to eq(2)
     end
 
     it "can find station with most rides ending there" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
 
       expect(Trip.most_rides_ending).to eq(3)
       expect(Trip.most_rides_ending).to have_content("Starter")
     end
 
     it "can find trip rides per month" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       
       expect(Trip.rides_per_month("September")).to eq(4)
    end
 
    it "can find trip rides per year" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       
       expect(Trip.rides_per_year("1989")).to eq(4)
     end
 
    it "can find most ridden bike" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 7, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_type: "Customer", zipcode_id: 81420)
       
       expect(Trip.most_ridden_bike).to eq(17)
    end
 
     it "can find least ridden bike" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 562, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_type: "Customer", zipcode_id: 81420)
 
       expect(Trip.least_ridden_bike).to eq(7)
     end

     it "can find user subscription stats" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_type: "Subscriber", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_type: "Subscriber", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 367, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_type: "Subscriber", zipcode_id: 81420)
 
       expect(Trip.number_customers).to eq(2)
       expect(Trip.number_subscribers).to eq(3)
       expect(Trip.user_percentage("Customer")).to eq(40)
       expect(Trip.user_percentage("Suscriber")).to eq(60)
     end
     
     it "can find highest trip date" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 15, 1989", end_date: "September 15, 1989", start_station_id: 1, end_station_id: 1, bike_id: 7, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_type: "Customer", zipcode_id: 81420)
       
       expect(Trip.highest_trip_date).to eq("1989-09-09")
     end
 
     it "can find lowest trip date" do
       Trip.create(duration_in_seconds: 187, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 69, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 1, end_station_id: 2, bike_id: 7, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 271, start_date: "September 29, 1989", end_date: "September 29, 1989", start_station_id: 1, end_station_id: 1, bike_id: 17, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 560, start_date: "September 9, 1989", end_date: "September 9, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 363, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 2, bike_id: 9, subscription_type: "Customer", zipcode_id: 81420)
       Trip.create(duration_in_seconds: 561, start_date: "September 19, 1989", end_date: "September 19, 1989", start_station_id: 2, end_station_id: 1, bike_id: 9, subscription_type: "Customer", zipcode_id: 81420)
 
       expect(Trip.lowest_trip_date).to eq("1989-09-19")
     end
   end
 end 