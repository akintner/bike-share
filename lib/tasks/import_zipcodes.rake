require './app/models/zipcode_importer'
require './app/models/zipcode'

desc "Import zipcodes"
namespace :import do
  task :zipcodes do
    file = './db/csv/trips.csv'
    ZipcodeImporter.new(file).import
  end
end
