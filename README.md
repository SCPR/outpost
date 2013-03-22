#Outpost
[![Build Status](https://travis-ci.org/SCPR/outpost.png)](https://travis-ci.org/SCPR/outpost)

A Rails Engine for quickly standing up a CMS for a Newsroom.

## Dependencies
* `rails >= 3.2`
* `ruby >= 1.9.2`

## Installation
Add `gem 'outpost', github: 'SCPR/outpost'` to your Gemfile.

This gem also has some hard dependencies that aren't in the gemspec.
My goal is to reduce these dependencies as much as possible, but as this
was extracted from the KPCC application, these are fairly strict at this
point:

* `simple_form` - for Rails 3.2, the latest release is fine.
For Rails 4.0, you'll need to point your Gemfile to the [simple_form 
master branch](https://github.com/plataformatec/simple_form).
* `kaminari` - You need to use the 
[kaminari master branch](https://github.com/amatsuda/kaminari).
* `ckeditor_rails`
* `eco`
* `sass-rails`
* `bootstrap-sass`
* `coffee-rails`

## Usage

More documentation to come.

## Todo
A ton of stuff. Here is a sampler:

* Generators for resources (models, controllers).
* Add record versioning (needs to be extracted from the SCPRv4 app).
* Make the engine's layout actually work.
* Documentation... oh man, the documentation...

## Contributing
Pull Requests are encouraged! This engine was built specifically for KPCC, 
so its flexibility is limited... if you have improvements to make, please 
make them.

Fork it, make your changes, and send me a pull request.

Run tests with `bundle exec rake test`
