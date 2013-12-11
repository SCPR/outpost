##
# Outpost::Controller::Actions
#
# This provides basic CRUD actions for you to include into any
# controller that you want to behave like a resource management
# area.
module Outpost
  module Controller
    module Actions
      def index
        respond_with :outpost, @records
      end

      def new
        breadcrumb "New"
        @record = model.new
        respond_with :outpost, @record
      end

      def show
        redirect_to @record.admin_edit_path
      end

      def edit
        breadcrumb "Edit", nil, @record.to_title
        respond_with :outpost, @record
      end

      def create
        @record = model.new(form_params)

        if @record.save
          notice "Saved #{@record.simple_title}"
          respond_with :outpost, @record, location: requested_location
        else
          breadcrumb "New"
          render :new
        end
      end

      def update
        if @record.update_attributes(form_params)
          notice "Saved #{@record.simple_title}"
          respond_with :outpost, @record, location: requested_location
        else
          breadcrumb "Edit", nil, @record.to_title
          render :edit
        end
      end

      def destroy
        @record.destroy
        notice "Deleted #{@record.simple_title}"
        respond_with :outpost, @record
      end

      private

      def form_params
        params[model.singular_route_key]
      end

      def requested_location
        case params[:commit_action]
        when "edit" then @record.admin_edit_path
        when "new"  then model.admin_new_path
        else model.admin_index_path
        end
      end
    end # Actions
  end # Controller
end # Outpost
