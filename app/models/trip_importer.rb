class TripImporter
  attr_reader :filename,
  :number_of_lines

  def initialize(filename)
    @filename = filename
    @number_of_lines = `wc -l #{filename}`.to_i
  end

  def import
    bar = ProgressBar.create(title: "Trips", total: number_of_lines)

    CSV.foreach(filename, headers: true) do |row|
      duration_in_seconds   = to_seconds(row['duration'])
      start_date            = to_date(row['start_date'])
      end_date              = to_date(row['end_date'])
      # start_station       = row['end_station_name']
      # end_station         = row['start_station_name']
      subscription_type     = row['subscription_type']
      zipcode_id            = row['zip_code']

      trip = Trip.new(
        duration_in_seconds:  duration_in_seconds,
        start_date:           start_date,
        end_date:             end_date,
        # start_station:      start_station,
        # end_station:        end_station,
        subscription_type:    subscription_type,
        zipcode_id:           zipcode_id
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
      DateTime.strptime(string, '%m/%e/%Y %H:%M')
    end
  end

  def get_float(string)
    if string.nil?
      nil
    else
      string.strip.to_f
    end
  end

  def to_seconds(string)
    if string.nil?
      nil
    else
      string.strip.to_i
    end
  end
end
