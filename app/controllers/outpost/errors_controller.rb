class Outpost::ErrorsController < Outpost::BaseController
  def not_found
    render_error(404, ActionController::RoutingError.new("Not Found")) and return
  end
end
