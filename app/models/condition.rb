require 'pry'

class Condition < ActiveRecord::Base
  validates :max_temperature_f, presence: true
  validates :mean_temperature_f, presence: true
  validates :min_temperature_f, presence: true
  validates :humidity_percent, presence: true
  validates :visibility_miles, presence: true
  validates :mean_wind_speed_mph, presence: true
  validates :precipitation_inches, presence: true
  validates :measurement_date, presence: true
  
  def self.average_rides(arg)
    (arg / Trip.count).round(4)
  end

  def self.highest_rides(arg)
  end

  def self.lowest_rides(arg)
  end

  def self.rides_by_temperature
    a = Trip.where(end_date: @temp_range).count
    b = Trip.where(start_date: @temp_range).count
    
    all = a + b
  end

  def self.rides_by_precip
    a = Trip.where(end_date: @precip_range).count
    b = Trip.where(start_date: @precip_range).count
    all = a + b
  end

  def self.rides_by_wind
    a = Trip.where(end_date: @wind_range).count
    b = Trip.where(start_date: @wind_range).count
    all = a + b
  end

  def self.rides_by_visibility
    a = Trip.where(end_date: @visibility_range).count
    b = Trip.where(start_date: @visibility_range).count
    all = a + b  
  end

  def self.days_by_temperature(temp)
    all = self.where(max_temperature_f: [temp..(temp+9)])
    dates = all.order("measurement_date")
    earliest = dates.first.measurement_date
    most_recent = dates.last.measurement_date
    @temp_range = [earliest, most_recent]
  end

  def self.days_by_precip(inches)
    all = self.where(precipitation_inches: [(inches-0.49)..inches])
    dates = all.order("measurement_date")
    earliest = dates.first.measurement_date
    most_recent = dates.last.measurement_date
    @precip_range = [earliest, most_recent]
  end

  def self.days_by_wind(speed)
    all = self.where(mean_wind_speed_mph: [(speed-3.9)..speed])
    dates = all.order("measurement_date")
    earliest = dates.first.measurement_date
    most_recent = dates.last.measurement_date
    @wind_range = [earliest, most_recent]
  end

  def self.days_by_visibility(miles)
    all = self.where(visibility_miles: [(miles-4)..miles])
    dates = all.order("measurement_date")
    earliest = dates.first.measurement_date
    most_recent = dates.last.measurement_date
    @visibility_range = [earliest, most_recent]
  end

  
end
