$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "outpost/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "outpost"
  s.version     = Outpost::VERSION
  s.authors     = ["Bryan Ricker", "SCPR"]
  s.email       = ["bricker@scpr.org"]
  s.homepage    = "http://github.com/SCPR/outpost"
  s.summary     = "A Rails Engine for quickly standing up a CMS for a Newsroom"
  s.description = "This engine plugs into your Rails application and provides a plethora of useful methods, concerns, helpers, and conventions to help you quickly build a CMS for your Newsroom."


  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
