require './app/models/condition_importer'
require './app/models/condition'

desc "Import conditions"
namespace :import do
  task :conditions do
    file = './db/csv/weather.csv'
    ConditionImporter.new(file).import
  end
end
