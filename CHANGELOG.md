### 0.0.3 (unreleased)
* Remove multipart from new form. Need to add a way to specify multipart without
  overwriting the entire partial.
* Add `render_json` utility helper method, for rendering jbuilder templates as
  raw JSON objects.
* Deprecated `link_path` - replaced with `public_path`
* Deprecated `remote_link_path` - replaced with `public_url`
* Added *_url methods for routing. Now you can call, for example,
  `admin_edit_url`, which delegates to the `outpost_model_name_url` method,
  just like the `admin_edit_path` method.
* Added routing aliases for `create`, `update`, and `destroy`. Now you can
  call, for example, `PUT object.admin_update_path`. 
* `render_error` no longer returns false.
* Use `update_column` for updating a user's last_login, so it doesn't generate
  a version in Secretary.
* `per_page = :all` is removed because Kaminari reverted this feature.
