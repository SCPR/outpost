$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "outpost/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "outpost-cms"
  s.version     = Outpost::VERSION
  s.authors     = ["Bryan Ricker", "SCPR"]
  s.email       = ["bricker@scpr.org"]
  s.homepage    = "http://github.com/SCPR/outpost"
  s.summary     = "A Rails Engine for quickly standing up a CMS for a Newsroom"
  s.description = "This engine plugs into your Rails application and provides a plethora of useful methods, concerns, helpers, and conventions to help you quickly build a CMS for your Newsroom."
  s.license     = 'MIT'

  s.files = Dir["{app,config,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", [">= 3.2", "< 5"]
  s.add_dependency "jquery-rails", "~> 3.0"
  s.add_dependency "bcrypt-ruby", [">= 3.0.0", "< 4"]
  s.add_dependency 'select2-rails', '3.4.1'
  s.add_dependency 'kaminari', '~> 0.15.1'
end
