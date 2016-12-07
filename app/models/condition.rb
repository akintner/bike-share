class Condition < ActiveRecord::Base
  validates :max_temperature_f, presence: true
  validates :mean_temperature_f, presence: true
  validates :min_temperature_f, presence: true
  validates :humidity_percent, presence: true
  validates :visibility_miles, presence: true
  validates :mean_wind_speed_mph, presence: true
  validates :precipitation_inches, presence: true
  validates :measurement_date, presence: true
  
  
  def self.rides_by_temperature(temp)
  end

  def self.rides_by_precip(inches)
  end

  def self.rides_by_wind(speed)
  end

  def self.rides_by_visibility(miles)
    #get trips by range, find max, find mind, find average
  end

   def self.days_by_temperature(temp)
    self.where(max_temperature_f: [temp..(temp+9)])
    dates = all.order("measurement_date")
    earliest = date.first
    most_recent = date.last
  end

  def self.days_by_precip(inches)
    self.where(precipitation_inches: [(inches-0.49)..inches])
    dates = all.order("measurement_date")
    earliest = date.first
    most_recent = date.last
  end

  def self.days_by_wind(speed)
    all = self.where(mean_wind_speed_mph: [(speed-3.9)..speed])
    dates = all.order("measurement_date")
    earliest = date.first
    most_recent = date.last
  end

  def self.days_by_visibility(miles)
    all = self.where(visibility_miles: [(miles-4)..miles])
    dates = all.order("measurement_date")
    earliest = date.first
    most_recent = date.last
  end

  
end
