class Station < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :dock_count, numericality: { only_integer: true }
  validates :installation_date, presence: true
  validates :city_id, presence:true

  belongs_to :city
  has_many :start_stations, :class_name => 'Trip', :foreign_key => 'start_station_id'
  has_many :end_stations,   :class_name => 'Trip', :foreign_key => 'end_station_id'

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

  def self.number_rides_started_at_station(station)
    Trip.where(start_station_id: station).count
  end

  def self.number_rides_ended_at_station(station)
    Trip.where(end_station_id: station).count
  end

  def self.station_with_most_rides_as_start_location(station)
    destination_station_id = Trip.where(start_station_id: station).group(:end_station_id).count("id").max_by{|bike, count| count }
    Station.where(id: destination_station_id).pluck(:name)
  end

  def self.station_with_most_rides_as_end_location(station)
    origin_station_id = Trip.where(start_station_id: station).group(:start_station_id).count("id").max_by{|bike, count| count }
    Station.where(id: origin_station_id).pluck(:name)
  end

  def self.date_with_highest_number_trips(station)
    Trip.where(start_station_id: station).group(:start_date).count("id").max_by{|date, count| count }
  end

  def self.most_frequent_user_zip_code(station)
    Trip.where(start_station_id: station).group(:user_zip_code).count("id").max_by{|zip_code, count| count }
  end

  def self.most_frequent_bike_id(station)
    Trip.where(start_station_id: station).group(:bike_id).count("id").max_by{|bike, count| count }
  end

end
