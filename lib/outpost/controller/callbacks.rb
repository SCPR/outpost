module Outpost
  module Controller
    module Callbacks
      extend ActiveSupport::Concern
      
      included do
        include Outpost::Controller::Helpers

        before_filter :remove_preferences, only: [:index, :search]
        before_filter :set_order, :set_sort_mode, only: [:index, :search]
      end

      #-----------------

      def get_record
        @record = model.find(params[:id])
      end

      #-----------------

      def get_records
        @records = model.page(params[:page]).per(self.list.per_page)
      end

      #-----------------

      def order_records
        @records = @records.order("#{model.table_name}.#{order} #{sort_mode}")
      end

      #------------------
      # Set which attribute is doing the sorting
      #
      # If params[:order] is present, then set the
      # preference to that and return it.
      #
      # If not present, but preferred order is,
      # then use the preferred order.
      #
      # Otherwise use the list order.
      def set_order
        key = "#{model.content_key}_order"
        preferred_order = preference(key)

        @order = if params[:order].present?
          set_preference(key, params[:order])
        elsif preferred_order.present?
          preferred_order
        else
          list.default_order
        end
      end

      #------------------
      # Set the sort mode
      #
      # It will either be the requested sort mode, or if not available, 
      # then the table's default sort mode.
      def set_sort_mode
        key = "#{model.content_key}_sort_mode"
        preferred_sort_mode = preference(key)

        @sort_mode = if %w{ asc desc }.include?(params[:sort_mode])
          set_preference(key, params[:sort_mode])
        elsif preferred_sort_mode.present?
          preferred_sort_mode
        else
          list.default_sort_mode
        end
      end

      #-----------------
      # Remove the preference specified if available
      def remove_preferences
        preferred_sort_mode_key = "#{model.content_key}_sort_mode"
        preferred_order_key = "#{model.content_key}_order"

        if params[:sort_mode] == "" && preference(preferred_sort_mode_key).present?
          unset_preference(preferred_sort_mode_key)
        end

        if params[:order] == "" && preference(preferred_order_key).present?
          unset_preference(preferred_order_key)
        end
      end

      #-----------------
      
      def filter_records
        if params[:filter].is_a? Hash
          params[:filter].each do |attribute, value|
            next if value.blank?
            scope = "filtered_by_#{attribute}"

            if @records.klass.respond_to? scope
              @records = @records.send(scope, value)
            else
              @records = @records.where(attribute => value)
            end
          end
        end
      end
    end # Callbacks
  end # Controller
end # Outpost
