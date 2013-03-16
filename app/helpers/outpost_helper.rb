module OutpostHelper
  # Public: Maps the standard Rails flash keys (+notice+, +alert+) to the 
  # appropriate Bootstrap alert class (+success+, +error+ respectively).
  # Falls back to just returning the passed-in symbol as a string.
  #
  # name - The flash key as a Symbol.
  #
  # Examples
  #
  #   <div class="alert alert-<%= flash_alert_type(:notice) %>">
  #   # => <div class="alert alert-success">
  #
  # Returns String of appropriate CSS class for Bootstrap alerts.
  def flash_alert_type(name)
    name_bootstrap_map = {
      notice: "success",
      alert:  "error"
    }
    
    name_bootstrap_map[name.to_sym] || name.to_s
  end
end
