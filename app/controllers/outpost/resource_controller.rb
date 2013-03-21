class Outpost::ResourceController < Outpost::ApplicationController  
  before_filter :get_record, only: [:show, :edit, :update, :destroy]
  before_filter :get_records, only: [:index]
  before_filter :authorize_resource
  before_filter :order_records, only: [:index]
  before_filter :filter_records, only: [:index]
  before_filter :extend_breadcrumbs_with_resource_root

  respond_to :html, :json, :js

  #-----------------
  
  def extend_breadcrumbs_with_resource_root
    breadcrumb model.to_title.pluralize, model.admin_index_path
  end
end
