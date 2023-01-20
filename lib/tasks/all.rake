namespace :load do
  desc "Read the CSV file and load the information into the database"

  task all: :environment do
    Rake::Task['load:timesheets'].invoke
  end
end