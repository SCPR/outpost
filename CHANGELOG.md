### 0.0.4
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

#### Fixes
* None

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

