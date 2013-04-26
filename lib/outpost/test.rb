# Some test helpers

module Outpost
  module Test
    extend self

    # Populate the permissions table.
    # Especially useful when using truncation strategy.
    def create_permissions
      created = []

      Outpost.config.registered_models.each do |model|
        if !Permission.exists?(resource: model)
          created << Permission.create(resource: model)
        end
      end

      created
    end
  end
end
