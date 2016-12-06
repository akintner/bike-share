class ConditionImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = 'wc -l #{filename}'.to_i
  end

  def import
    bar = ProgressBar.create(title: "Stations", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|
      date                    = to_date(row['date'])
      max_temp_in_F           = row['max_temperature_f'].strip.to_f
      mean_temp_in_F          = row['mean_temperature_f'].strip.to_f
      min_temp_in_F           = row['min_temperature_f'].strip.to_f
      humidity_percentage     = row['mean_humidity'].strip.to_f
      visibility_in_miles     = row['mean_visibility_miles'].strip.to_f
      mean_wind_speed_in_mph  = row['mean_wind_speed_mph'].strip.to_f
      precipitation_in_inches = row['precipitation_inches'].strip.to_f

      Condition.create(
        date:                    date,
        max_temp_in_F:           max_temp_in_F,
        mean_temp_in_F:          mean_temp_in_F,
        min_temp_in_F:           min_temp_in_F,
        humidity_percentage:     humidity_percentage,
        visibility_in_miles:     visibility_in_miles,
        mean_wind_speed_in_mph:  mean_wind_speed_in_mph,
        precipitation_in_inches: precipitation_in_inches
      )

      bar.increment
    end
    bar.finish
  end

  private

    def to_date(string)
      Date.strptime(string, '%m/%e/%Y')
    end
end
