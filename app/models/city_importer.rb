require 'csv'

class CityImporter
  attr_reader :filename,
              :cities

  def initialize(filename)
    @filename = filename
    @cities = []
  end

  def import
    CSV.foreach(filename, headers: true) do |row|
      City.create(name: row['city'])
    end
  end

end
