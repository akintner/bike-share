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
      bike_id               = row['bike_id']
      start_station_name    = row['end_station_name']
      end_station_name      = row['start_station_name']
      subscription_name     = row['subscription_type']
      zipcode_value         = row['zip_code']

      start_station = Station.find_by(
        name: start_station_name
      )

      end_station = Station.find_by(
        name: end_station_name
      )

      subscription = Subscription.find_or_create_by(
        name: subscription_name
      )

      zipcode = Zipcode.find_or_create_by(
        zipcode: zipcode_value
      )

      trip = Trip.new(
        duration_in_seconds:  duration_in_seconds,
        start_date:           start_date,
        end_date:             end_date,
      )

      trip.start_station = start_station
      trip.end_station = end_station
      trip.subscription = subscription
      trip.zipcode = zipcode

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
