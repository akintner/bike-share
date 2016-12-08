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

      next unless row['zip_code'] == '94107'

      measurement_date     = to_date(row['date'])
      max_temperature_f    = get_float(row['max_temperature_f'])
      mean_temperature_f   = get_float(row['mean_temperature_f'])
      min_temperature_f    = get_float(row['min_temperature_f'])
      humidity_percent     = get_float(row['mean_humidity'])
      visibility_miles     = get_float(row['mean_visibility_miles'])
      mean_wind_speed_mph  = get_float(row['mean_wind_speed_mph'])
      precipitation_inches = get_float(row['precipitation_inches'])

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
      if string.nil?
        nil
      else
        Date.strptime(string, '%m/%e/%Y')
      end
    end

    def get_float(string)
      if string.nil?
        nil
      else
        string.strip.to_f
      end
    end
end
