module Outpost
  module Controller
    module Ordering
      private
      
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
    end
  end
end
