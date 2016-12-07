class Trip < ActiveRecord::Base
  validates :duration_in_seconds, numericality: { only_integer: true }
  validates :start_date,          presence: true
  validates :end_date,            presence: true
  validates :start_station,       presence: true
  validates :end_station,         presence: true
  validates :subscription_id,     presence: true
  validates :zipcode_id,          presence: true

  belongs_to :start_station, :class_name => "Station", :foreign_key => "start_station_id"
  belongs_to :end_station,   :class_name => "Station", :foreign_key => "end_station_id"
  belongs_to :subscription
  belongs_to :zipcode

  def subscription_name
    subscription.name
  end
end
