require './app/models/station_importer'
require './app/models/station'
require './app/models/city'

desc "Import stations"
namespace :import do
  task :stations do
    file = './db/csv/station.csv'
    StationImporter.new(file).import
  end
end
