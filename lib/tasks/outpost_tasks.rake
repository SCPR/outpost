namespace :outpost do
  desc "Update Permissions table with Outpost registered models"
  task :permissions => [:environment] do
    added = Outpost::Test.create_permissions
    puts "Added: #{added}"
  end
end
