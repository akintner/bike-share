require './spec/spec_helper'

describe "Condition" do
  context "attributes are validated" do
    let(:condition) { Condition.new(measurement_date: Date.today,
                                    max_temperature_f: 74.0,
                                    mean_temperature_f: 68.0,
                                    min_temperature_f: 61.0,
                                    humidity_percent: 75.0,
                                    visibility_miles: 10.0,
                                    mean_wind_speed_mph: 23.0,
                                    precipitation_inches: 11.0
                                   ) }

    it "validates presence of maximum temperature" do
      condition.max_temperature_f = nil
      expect(condition).not_to be_valid
    end

    it "validates presence of mean temperature" do
      condition.mean_temperature_f = nil
      expect(condition).not_to be_valid
    end

    it "validates presence of min temperature" do
      condition.min_temperature_f = nil
      expect(condition).not_to be_valid
    end

    it "validates presence of humidity" do
      condition.humidity_percent = nil
      expect(condition).not_to be_valid
    end

    it "validates presence of visibility" do
      condition.visibility_miles = nil
      expect(condition).not_to be_valid
    end

    it "validates presence of mean wind speed" do
      condition.mean_wind_speed_mph = nil
      expect(condition).not_to be_valid
    end

    it "validates presence of precipitation" do
      condition.precipitation_inches = nil
      expect(condition).not_to be_valid
    end

    it "validates measurement date is a date" do
      condition.measurement_date = nil

      expect(condition).not_to be_valid
    end

  end
end
