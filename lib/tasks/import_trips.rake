require './app/models/trip_importer'
require './app/models/trip'

desc "Import trips"
namespace :import do
  task :trips do
    file = './db/csv/trip.csv'
    TripImporter.new(file).import
  end
end
