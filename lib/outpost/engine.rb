module Outpost
  class Engine < ::Rails::Engine
    engine_name "outpost"

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
      g.assets false
      g.helper false
    end

    config.assets.paths << "vendor/assets/javascripts"
  end
end
