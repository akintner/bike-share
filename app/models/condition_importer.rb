class ConditionImporter
  attr_reader :filename,
              :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Conditions", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|
      measurement_date     = to_date(row['date'])
      max_temperature_f    = get_float(row['max_temperature_f'])
      mean_temperature_f   = get_float(row['mean_temperature_f'])
      min_temperature_f    = get_float(row['min_temperature_f'])
      humidity_percent     = row['mean_humidity'].strip.to_f
      visibility_miles     = row['mean_visibility_miles'].strip.to_f
      mean_wind_speed_mph  = row['mean_wind_speed_mph'].strip.to_f
      precipitation_inches = row['precipitation_inches'].strip.to_f



      condition = Condition.new(
        measurement_date:     measurement_date,
        max_temperature_f:    max_temperature_f,
        mean_temperature_f:   mean_temperature_f,
        min_temperature_f:    min_temperature_f,
        humidity_percent:     humidity_percent,
        visibility_miles:     visibility_miles,
        mean_wind_speed_mph:  mean_wind_speed_mph,
        precipitation_inches: precipitation_inches
      )

      condition.save if condition.valid?

      bar.increment
    end
    bar.finish
  end

  private

    def to_date(string)
      Date.strptime(string, '%m/%e/%Y')
    end

    def get_float(string)
      if string == ''
        nil
      else
        string.strip.to_f
      end
    end
end
