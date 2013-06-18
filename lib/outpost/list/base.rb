module Outpost
  module List
    class Base
      def initialize(model, &block)
        @model   = model
        @columns = ActiveSupport::HashWithIndifferentAccess.new
        @filters = ActiveSupport::HashWithIndifferentAccess.new
        @fields  = []

        yield self if block_given?

        @default_order     ||= List::DEFAULT_ORDER
        @default_sort_mode ||= List::DEFAULT_SORT_MODE
        @per_page          ||= List::DEFAULT_PER_PAGE
      end

      attr_accessor :default_order, :default_sort_mode
      attr_reader :columns, :fields, :filters, :per_page, :model
      
      # Public: Set the per_page for pagination.
      #
      # val - (Integer) The value to send to pagination. Also accepts :all,
      #       which passes `nil` to pagination and therefore will not 
      #       paginate.
      #
      # Returns nothing.
      def per_page=(val)
        @per_page = val.to_i
      end

      # Public: Add a column to the list.
      #
      # attribute - (String) The attribute that this column represents.
      # options   - (Hash) A hash of options. Gets passed directly to 
      #             List::Column (default: {}).
      #             * header  - (String) The title of the column, displayed in 
      #                         the table header 
      #                         (default: self.attribute.titleize).
      #             * display - (Symbol or Proc) How to display this attribute.
      #                         * If symbol, should be the name of a method in 
      #                           AdminListHelper
      #                         * If Proc, gets run as an instance of the class.
      #                         * See AdminListHelper for more info.
      #
      # Examples
      #
      #   define_list do
      #     column :name, header: "Full Name", display: :display_full_name
      #     column :user, header: "Associated User", display: proc { self.user.name }
      #   end
      #
      # Returns nothing.
      def column(attribute, options={})
        column = Column.new(attribute, self, options)
        @columns[attribute] = column
      end
      
      # Public: Define a filter for the list.
      #
      # attribute - (String) The attribute on which to filter.
      # options   - (Hash) A hash of options that gets passed into Filter.new
      #             (default: {}).
      #
      # Returns nothing.
      def filter(attribute, options={})
        filter = Filter.new(attribute, self, options)
        @filters[attribute] = filter
      end

      # Private: Default columns for this list
      #
      # Returns Array of default columns.
      def default_columns
        @model.column_names - Outpost.config.excluded_list_columns
      end
    end
  end
end
