class Station < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :dock_count, numericality: { only_integer: true }
  validates :installation_date, presence: true
  validates :city_id, presence:true

  belongs_to :city
  has_many :trip_departures, :class_name => 'Trip', :foreign_key => 'start_station_id'
  has_many :trip_arrivals,   :class_name => 'Trip', :foreign_key => 'end_station_id'

  def self.total
    Station.count
  end

  def self.average_available_bikes
    result = self.average("dock_count")
    result.to_f.round(0)
  end

  def self.most_bikes_available_at_station
    self.maximum("dock_count")
  end

  def self.stations_with_most_bikes(number)
    self.order("dock_count DESC").limit(number)
  end

  def self.fewest_bikes_available_at_station
    self.minimum("dock_count")
  end

  def self.stations_with_fewest_bikes(number)
    self.order("dock_count ASC").limit(number)
  end

  def self.most_recently_installed_name
    station = self.order("installation_date DESC").limit(1).first
    station.name
  end

  def self.most_recently_installed_date
    station = self.order("installation_date DESC").limit(1).first
    station.installation_date
  end

  def self.oldest_station_name
    station = self.order("installation_date ASC").limit(1).first
    station.name
  end

  def self.oldest_station_date
    station = self.order("installation_date ASC").limit(1).first
    station.installation_date
  end

  def number_of_rides_started_at_station
    self.trip_departures.count
  end

  def number_of_rides_ended_at_station
    self.trip_arrivals.count
  end

  def most_frequent_destination_station
    trips = self.trip_departures.group(:end_station).count
    trips.first[0].name
  end

  def most_frequent_origination_station
    trips = self.trip_arrivals.group(:start_station).count
    trips.first[0].name
  end

  def date_with_most_trips
    trips = self.trip_departures.group(:start_date).count
    trips.first[0].strftime('%m/%d/%Y')
  end

  def frequent_user_zipcode
    zipcodes = self.trip_departures.group(:zipcode).count
    zipcodes.first[0].zipcode
  end

  def most_used_bike
    bikes = self.trip_departures.group(:bike_id).count
    bikes.first[0]
  end

  def most_used_bike_total_rides
    bikes = self.trip_departures.group(:bike_id).count
    bikes.first[1]
  end
end
