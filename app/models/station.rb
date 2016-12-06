class Station < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :dock_count, numericality: { only_integer: true }
  validates :installation_date, presence: true

  belongs_to :city

  def self.total
    Station.count
  end

  def self.average_available_bikes
    result = self.average("dock_count")
    result.to_f
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

end
