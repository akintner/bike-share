class TripImporter
  attr_reader :filename,
  :number_of_lines

  def initialize(filname)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Trips", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|
      duration_in_seconds   = row['duration'].strip.to_i
      start_date            = to_date(row['start_date'])
      end_date              = to_date(row['end_date'])
      # start_station         = row['end_station_name']
      # end_station           = row['start_station_name']
      subscription_type     = row['subscription_type'].strip.to_i
      # zipcode_id            = row['zip_code'].strip_to_i

      trip = Trip.new(
        duration_in_seconds:  duration_in_seconds,
        start_date:           start_date,
        end_date:             end_date,
        # start_station:        start_station
        # end_station:          end_station
        subscription_type:    subscription_type
        # zipcode_id:           zipcode_id
      )

      trip.save if trip.valid?

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
