# Outpost
[![Build Status](https://travis-ci.org/SCPR/outpost.png)](https://travis-ci.org/SCPR/outpost)

A Rails Engine for quickly standing up a CMS for a Newsroom.

## Dependencies
* `rails >= 3.2`
* `ruby >= 1.9.3`

See `.travis.yml` to see which Ruby versions are officially supported.

## Installation
Add `gem 'outpost', github: 'SCPR/outpost'` to your Gemfile.

This gem also has some hard dependencies that aren't in the gemspec.
My goal is to reduce these dependencies as much as possible, but as this was 
extracted from the KPCC application, these are fairly strict at this point.

* `simple_form` - for Rails 3.2, use `~> 2.1.0`.
For Rails 4.0, you'll need to use `~> 3.0.0.beta1`
* `kaminari` - You need to use the 
[kaminari master branch](https://github.com/amatsuda/kaminari).
* `ckeditor_rails`
* `eco`
* `sass-rails`
* `bootstrap-sass`
* `coffee-rails`

## Usage
### Authentication
Much like Devise, Outpost provides a basic `SessionsController` and 
corresponding views. To use these, just add them to your routes:

```ruby
namespace :outpost do
  resources :sessions, only: [:create, :destroy]
  get 'login'  => "sessions#new", as: :login
  get 'logout' => "sessions#destroy", as: :logout
end
```

Outpost also provides the `Outpost::Model::Authentication` module,
which you should include into your User model to work with the provided
`SessionsController`:

```ruby
class User < ActiveRecord::Base
  include Outpost::Model::Authentication
end
```

Your User class should have at least the following methods:
* `password_digest` (string)
* `last_login` (datetime)
* `can_login` (boolean)
* `is_superuser` (boolean)
* `name` (string)


#### Configuration

You can set a different User class, or the attribute which the user 
should use to login:

```
Outpost::Config.configure do |config|
  config.user_class                   = "AdminUser"
  config.authentication_attribute     = :username
end
```


### Authorization
Outpost comes with a built-in `Permission` model, whose only attribute is
a String `resource`, which stores a class name which you want to be
authorized throughout the application. Run this migration to set it up:


```ruby
create_table :permissions do |t|
  t.string :resource
  t.timestamp
end

create_table :user_permissions do |t|
  t.integer :user_id
  t.integer :permission_id
  t.timestamps
end

add_index :permissions, :resource
add_index :user_permissions, :user_id
add_index :user_permissions, :permission_id
```

You can include `Outpost::Model::Authorization` into your User model
to provide the Permission association, and also add the `can_manage?` 
method:

```ruby
if !current_user.can_manage?(Post)
  redirect_to outpost_root_path, alert: "Not Authorized"
end
```

Authorization is "All-or-None"... in other words, a user can either 
manage a resource or not - A user with permission for a particular model
is able to Create, Read, Update, and Delete any of those objects.

Outpost controllers will automatically authorize their resource. Within
views, you can use one of the provided helpers to guard a block of text
or a link:

```erb
<%= guard Post do %>
  Only users who are authorized for Posts will see this.
<% end %>

<%= guarded_link_to Post, "Linked if authorized, plaintext if not", posts_path %>
```


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
