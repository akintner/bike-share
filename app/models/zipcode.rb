class Zipcode < ActiveRecord::Base
  validates :zipcode,   presence: true
  validates :zipcode, uniqueness: true
  validates_length_of :zipcode, :is => 5

  has_many :trips
end
