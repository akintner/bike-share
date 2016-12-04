require './app/models/city_importer'
require './app/models/city'

desc "Import cities"
namespace :import do
  task :cities do
    file = './db/csv/station.csv'
    CityImporter.new(file).import
  end
end
