require 'pry'

class Trip < ActiveRecord::Base
  validates :duration_in_seconds, numericality: { only_integer: true }
  validates :start_date,          presence: true
  validates :end_date,            presence: true
  validates :start_station,       presence: true
  validates :end_station,         presence: true
  validates :bike_id,             presence: true
  validates :subscription_type,   presence: true
  validates :zipcode_id,          presence: true

  belongs_to :start_station, :class_name => "Station", :foreign_key => "start_station_id"
  belongs_to :end_station,   :class_name => "Station", :foreign_key => "end_station_id"

  def self.total
    Trip.count
  end

  def self.average_duration_of_ride
    self.average("duration_in_seconds").to_f.round(0)
  end

  def self.longest_ride
    self.maximum("duration_in_seconds")
  end

  def self.shortest_ride
    self.minimum("duration_in_seconds")
  end

  def self.most_rides_starting
    most = self.select("start_station_id").group("start_station_id").count
    most.values.max
  end

  def self.most_rides_ending
    most = self.select("end_station_id").group("end_station_id").count
    most.values.max
  end

  def self.rides_per_month(month)
    
    self.where(end_date: month).count
  end

  def self.rides_per_year(year)
    self.select("end_date").group("end_date")
  end

  def self.most_ridden_bike
    most = self.select("bike_id").group("bike_id").count
    puts most.values.max
  end
  
  def self.least_ridden_bike
    least = self.select("bike_id").group("bike_id").count
    puts least.values.min
  end

  def self.number_customers
    self.where(subscription_type: "Customer").count
  end

  def self.number_subscribers
    self.where(subscription_type: "Subscriber").count
  end

  def self.user_percentage(user_type)
    self.where(subscription_type: user_type).count / Trip.count
  end

  def self.highest_trip_date
    most = self.select("end_date").group("end_date").count
    most.values.max
  end

  def self.lowest_trip_date
    least = self.select("end_date").group("end_date").count
    least.values.min
  end

end
