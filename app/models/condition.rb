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
  end

end
