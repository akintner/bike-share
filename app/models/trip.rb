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
    station = Station.find(most.invert.values.max)
    "#{station.name} = #{most.values.max}"
  end

  def self.most_rides_ending
    most = self.select("end_station_id").group("end_station_id").count
    station = Station.find(most[most.invert.values.max])
    "#{station.name} = #{most.values.max}"
  end

  def self.rides_per_month(month)
    given_month = Trip.where('extract(month FROM end_date)= ?', month)
    "#{month} = #{given_month.count}"   
  end

  def self.rides_per_year(year)
    given_year = Trip.where('extract(year FROM end_date)= ?', year)
    "#{year} = #{given_year.count}"
  end

  def self.most_ridden_bike
    most = self.group("bike_id").order("bike_id").count
    most.invert
    bike = most.max
    "#{bike[0]}"
  end
  
  def self.least_ridden_bike
    least = self.group("bike_id").order("bike_id").count
    least.invert
    bike = least.min
    "#{bike[0]}"
  end

  def self.number_customers
    "Customers = #{self.where(subscription_type: 0).count}"
  end

  def self.number_subscribers
    "Subscribers = #{self.where(subscription_type: 1).count}"
  end

  # def self.user_percentage(user_type)
  #   user_type.to_i
  #   (self.where(subscription_type: user_type).count) / Trip.count
  # end

  def self.highest_trip_date
    most = self.select("end_date").group("end_date").count
    most.invert[most.values.max]
  end

  def self.lowest_trip_date
    least = self.select("end_date").group("end_date").count
    least.invert[least.values.min]
  end

  def self.weather_on_highest_trip_date
    conditions = Condition.find_by(measurement_date: highest_trip_date)
    binding.pry
    conditions.id
  end

  def self.weather_on_worst_trip_date
    conditions = Condition.find_by(measurement_date: lowest_trip_date)
    conditions.id
  end

end
