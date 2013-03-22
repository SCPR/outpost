# Outpost
[![Build Status](https://travis-ci.org/SCPR/outpost.png)](https://travis-ci.org/SCPR/outpost)

A Rails Engine for quickly standing up a CMS for a Newsroom.

## Dependencies
* `rails >= 3.2`
* `ruby >= 1.9.2`

## Installation
Add `gem 'outpost', github: 'SCPR/outpost'` to your Gemfile.

This gem also has some hard dependencies that aren't in the gemspec.
My goal is to reduce these dependencies as much as possible, but as this was 
extracted from the KPCC application, these are fairly strict at this point:

* `simple_form` - for Rails 3.2, the latest release is fine.
For Rails 4.0, you'll need to point your Gemfile to the 
[simple_form master branch](https://github.com/plataformatec/simple_form).
* `kaminari` - You need to use the 
[kaminari master branch](https://github.com/amatsuda/kaminari).
* `ckeditor_rails`
* `eco`
* `sass-rails`
* `bootstrap-sass`
* `coffee-rails`

## Usage
### Preferences
Preferences are stored in the session, and on a per-resource basis.
Outpost provides built-in hooks in the controller and views for 
Order (attribute) and Sort Mode ("asc", "desc"). In order to manage other 
preferences, you'll want to make use of a handful of methods that get
mixed-in to your Outpost controllers:

* `preference` - Access a preference's value.
* `set_preference` - Set a preference's value.
* `unset_preference` - Unset a preference's value.

The key for a preference needs to follow the convention:

```ruby
"#{model.content_key}_#{preference}"
```

For example:

```ruby
set_preference("blog_entries_color", "ff0000")
```

You also need to add the parameter that the preference is using to 
`config.preferences`:

```ruby
Outpost::Config.configure do |config|
  # ...
  config.preferences += [:color]
end
```

A resource-based preference is automatically cleared if its param is an empty string (not `nil`). For example:

```ruby
# GET /outpost/posts?color=ff0000
set_preference('posts_color', params[:color])
preference('posts_color') # => ff0000

# GET /outpost/posts?color=
preference('posts_color') # => nil
```

If you have a preference for a non-resourceful page, you need to manage its
cleanup manually.

#### More documentation to come.

## Todo
A ton of stuff. Here is a sampler:

* Generators for resources (models, controllers).
* Add record versioning (needs to be extracted from the SCPRv4 app).
* Documentation... oh man, the documentation...

## Contributing
Pull Requests are encouraged! This engine was built specifically for KPCC, 
so its flexibility is limited... if you have improvements to make, please 
make them.

Fork it, make your changes, and send me a pull request.

Run tests with `bundle exec rake test`
