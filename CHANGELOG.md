### 0.0.4 (Unreleased)
#### Additions
* None
#### Changes
* Update bcrypt-ruby dependency to `>= 3.0.0` to support Rails 4.1

#### Fixes
* None

#### Deprecations
* None



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

