require 'csv'

class CityImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Cities", total: number_of_lines)

    City.transaction do
      CSV.foreach(filename, headers: true) do |row|
        City.create(name: row['city'])

        bar.increment
      end
      bar.finish
    end
  end

end
