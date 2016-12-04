class City < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :stations
end
