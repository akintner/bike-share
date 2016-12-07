require 'csv'

class ZipcodeImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Zipcodes", total: number_of_lines)

    Zipcode.transaction do
      CSV.foreach(filename, headers: true) do |row|
        Zipcode.create(zipcode: row['zip_code'])

        bar.increment
      end
      bar.finish
    end
  end

end
