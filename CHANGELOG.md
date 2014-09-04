### 0.1.3 (2014-09-03)
#### Changes
* Use `Time.zone.now` instead of `Time.now`


### 0.1.2 (2014-05-30)
#### Changes
* Add vendor/ to gem files.


### 0.1.1 (2014-05-30)
#### Changes
* Added vendor/assets/javascripts to config.assets.paths


### 0.1.0 (2014-05-30)
#### Changes
* [BREAKING] Outpost now provides routes via mount. To use it, add it above your `outpost` namespace in your routes file. This mount is required by Outpost. To use it, add in your routes:

```ruby
Rails.application.routes.draw do
  # ...

  # ADD THIS LINE
  mount Outpost::Engine, at: "outpost"

  namespace :outpost do
    resources :posts

    # Add outpost-specific 404 pages.
    # This must be at the very bottom of the namespace.
    get "*path" => 'errors#not_found'
  end
end
```

You may then remove the `root`, `logout`, `login`, and `sessions` routes, as Outpost provides them for you. If you're using a bunch of custom code which still references `outpost_root_path`, for example, you can leave the old routes in place, but you still need to add the mount.

* Added optional `template_prefix` argument to `render_error`.
* Removed `outpost_model` from Permission.

#### Additions
* Added `route_proxy` helper to controllers. This was originally to get around [a kaminari bug](https://github.com/amatsuda/kaminari/issues/457), but can be useful for other reasons.



### 0.0.5 (2014-03-19)
#### Additions
* Added the ability to specify options when declaring outpost model:

```ruby
class Article < ActiveRecord::Base
  outpost_model public_route_key: "article"

  # ...
end
```

* Bootstrap typeahead is now included in javascript by default. It is recommended that you just override the included javascripts.
* Add some basic default column stying.
* Smarter building of filter options.
* Logo is now always an image. Override assets/images/outpost/logo.png to customize it.

#### Changes
* Fixed bcrypt-ruby dependency versions.

#### Fixes
* Fix error when Permissions aren't being used. This is a wip, as Permissions will eventually be totally optional.

#### Deprecations
* Deprecated `ROUTE_KEY` for defining the public route path helper keys. Use `self.public_route_key = "..."` instead.


### 0.0.4 (2014-02-13)
#### Additions
* Added `utilities.js`, which will include some utilities functions to use
  on various pages. First one is `preventEnterFromSubmittingForm()`.
* Added `new_obj_key` class method to Identifier module. `news_story-new`
* Added a bunch of functions to Notifications.
* Added `FormBuilder#full_errors`, which renders full error messages for an attribute in an ALERT div. This is useful for when you have a validation on an attribute, but don't actually have a field for that attribute in the model, so simple_form can't attach the error to any field.

#### Changes
* Update bcrypt-ruby dependency to `>= 3.0.0` to support Rails 4.1
* Minor style tweaks
* [BREAKING] Changed the obj_key format to be url-safe. New format is
  `news_story-999`.
* [BREAKING] `sort_mode_icon` helper renamed to `direction_icon`
* [BREAKING] `switch_sort_mode` helper renamed to `switch_direction`
* [BREAKING] `order` helper renamed to `order_attribute`
* [BREAKING] `sort_mode` helper renamed to `order_direction`
* [BREAKING] `order` helper now returns a contatenation of `order_attribute`
  and `order_direction`.
* [BREAKING] Moves ordering helpers into `controller/ordering.rb`
* [BREAKING] `Column#default_sort_mode` renamed to `default_order_direction`
* [BREAKING] `List#default_sort_mode` renamed to `default_order_direction`
* [BREAKING] `List#default_order` renamed to `default_order_attribute`
* [BREAKING] Renamed default preferences: `sort_mode` -> `order_direction`,
  `order` -> `order_attribute`
* [BREAKING] Order directions are now in CAPS (ASC, DESC)
* Changed text on Delete button to keep it from being Bui'd.
* List Helpers can now accept two arguments: The attribute value, and the record.
  If your list helper only accepts one argument, then only the attribute value
  will be passed in. If it accepts a second argument, the record will also be
  passed in.

#### Fixes
* Register an event handler on content forms and submit buttons which prevents the form from being submitted twice by double-click. Add class `js-content-form` to your form and class `js-submit-btns` to the div wrapping the submit buttons to activate. This is turned on by default.


#### Deprecations
* None

#### Removals
* Removed bootstrap-tooltip.


### 0.0.3 (2013-07-29)
#### Additions
* Add `render_json` utility helper method, for rendering jbuilder templates as
  raw JSON objects.
* Added *_url methods for routing. Now you can call, for example,
`admin_edit_url`, which delegates to the `outpost_model_name_url` method,
just like the `admin_edit_path` method.
* Added routing aliases for `create`, `update`, and `destroy`. Now you can
call, for example, `PUT object.admin_update_path`. 

#### Changes
* Rename gem to `outpost-cms`. The module is still `Outpost`.
* Remove multipart from new form. Need to add a way to specify multipart without
  overwriting the entire partial.
* `render_error` no longer returns false.
* `per_page = :all` is removed because Kaminari reverted this feature.

#### Fixes
* Use `update_column` for updating a user's last_login, so it doesn't generate
  a version in Secretary.

#### Deprecations
* Deprecated `link_path` - replaced with `public_path`
* Deprecated `remote_link_path` - replaced with `public_url`

