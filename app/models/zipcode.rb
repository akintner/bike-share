class Zipcode < ActiveRecord::Base
  validates :zipcode,   presence: true
  validates :zipcode, uniqueness: true


  has_many :trips
end
