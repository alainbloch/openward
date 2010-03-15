namespace :db do
  desc "Loads the initial data for the application into the current environment's database."
  task :load_initial_data => :environment do
    ActiveRecord::Base.establish_connection(RAILS_ENV)
    Dir.foreach("#{RAILS_ROOT}/db/initial_data/") do |file|
      puts "loading #{file}..."
      if File.extname(file) == ".sql"  
        IO.readlines("#{RAILS_ROOT}/db/initial_data/#{file}").join.split("\n\n").each do |table|
          ActiveRecord::Base.connection.execute(table)
        end  
        puts "file load complete!\n------------------"
      else
        puts "file does not have valid extension.\n------------------"
      end
    end
    puts "Initial data loaded into the #{RAILS_ENV} database."
  end
  
end