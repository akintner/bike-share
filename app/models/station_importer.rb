class StationImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Stations", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|
      name = row['name']
      dock_count = row['dock_count'].strip.to_i
      installation_date = to_date(row['installation_date'])
      city = find_city(row['city'])

      Station.create(
        name: name,
        dock_count: dock_count,
        installation_date: installation_date,
        city: city
      )

      bar.increment
    end
    bar.finish
  end

  private

    def to_date(string)
      Date.strptime(string, '%m/%e/%Y')
    end

    def find_city(name)
      City.find_by(name: name)
    end
end
