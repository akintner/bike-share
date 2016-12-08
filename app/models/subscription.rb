class Subscription < ActiveRecord::Base
  validates :name, presence: true

    has_many :trips
end
