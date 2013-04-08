class Outpost::ErrorsController < Outpost::BaseController
  def not_found
    render_error(404, ActionController::RoutingError.new("Not Found")) and return
  end

  def trigger_error
    raise StandardError, "This is a test error. It works (or does it?)"
  end
end
