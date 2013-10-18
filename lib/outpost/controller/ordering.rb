module Outpost
  module Controller
    module Ordering
      extend ActiveSupport::Concern

      included do
        helper_method :order_direction, :order_attribute, :order
      end

      # Public: The order that the records are currently sorted by.
      # This gets passed directly to ActiveRecord, so it should be
      # a valid database order.
      #
      # Returns String of the order.
      def order_attribute
        @order_attribute ||= set_order_attribute
      end

      # Public: The sort mode that the records are currently sorted by.
      # This gets passed directory to ActiveRecord, so it should be
      # a valid database sort mode.
      #
      # Examples
      #
      #   order_direction
      #   # => "ASC"
      #
      # Returns String of the sort mode.
      def order_direction
        @order_direction ||= set_order_direction
      end

      # Public: The order string to be passed into ActiveRecord
      #
      # Examples
      #
      #   order
      #   # => "updated_at DESC"
      #
      # Returns String of the order.
      def order
        @order ||= "#{order_attribute} #{order_direction}"
      end


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
      def set_order_attribute
        key = "#{model.content_key}_order_attribute"
        preferred_order = preference(key)

        @order_attribute = if params[:order].present?
          set_preference(key, params[:order])
        elsif preferred_order.present?
          preferred_order
        else
          list.default_order_attribute
        end
      end

      # Set the order direction
      #
      # It will either be the requested direction, or if not available, 
      # then the table's default direction.
      def set_order_direction
        key = "#{model.content_key}_order_direction"
        preferred_direction = preference(key)

        @order_direction = if [Outpost::ASCENDING, Outpost::DESCENDING]
        .include?(params[:direction])
          set_preference(key, params[:direction])
        elsif preferred_direction.present?
          preferred_direction
        else
          list.default_order_direction
        end
      end
    end
  end
end
