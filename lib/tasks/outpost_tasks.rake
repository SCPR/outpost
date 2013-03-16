namespace :outpost do
  desc "Update Permissions table with Outpost registered models"
  task :permissions => [:environment] do
    Outpost.config.registered_models.each do |model|
      if !Permission.exists?(resource: model)
        $stdout.puts "Adding #{model}"
        Permission.create(resource: model)
      end
    end
  end
end
