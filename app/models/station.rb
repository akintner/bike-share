class Station < ActiveRecord::Base
  validates :name, presence: true
  validates :dock_count, numericality: { only_integer: true }
  validates :installation_date, presence: true

  belongs_to :city
end
