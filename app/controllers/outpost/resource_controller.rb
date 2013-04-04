module Outpost
  class ResourceController < Outpost::BaseController
    before_filter :extend_breadcrumbs_with_resource_root
    respond_to :html, :json, :js

    #-----------------
    
    def extend_breadcrumbs_with_resource_root
      breadcrumb model.to_title.pluralize, model.admin_index_path
    end
  end
end
