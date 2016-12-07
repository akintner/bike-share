desc "Import all CSVs"
namespace :import do
  task :all do
    Rake::Task['import:conditions'].execute
    Rake::Task['import:cities'].execute
    Rake::Task['import:stations'].execute
    Rake::Task['import:zipcodes'].execute
    Rake::Task['import:trips'].execute
  end
end
