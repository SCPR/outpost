module Outpost
  module List
    class Base
      def initialize(model, &block)
        @model = model
        
        @columns = []
        @filers  = []
        @filters = []
        
        instance_eval(&block) if block_given?

        @default_order     ||= List::DEFAULT_ORDER
        @default_sort_mode ||= List::DEFAULT_SORT_MODE
        @per_page          ||= List::DEFAULT_PER_PAGE
      end
      
      attr_accessor :default_order, :default_sort_mode
      attr_reader :columns, :fields, :filters, :per_page, :model

      # Alias the writer methods so that we can use them in the 
      # define_list without an explicit caller.
      alias_method :list_default_order, :default_order=
      alias_method :list_default_sort_mode, :default_sort_mode=
      
      # Return nil if per_page is set to :all
      # So that pagination will not paginate
      def per_page=(val)
        @per_page = (val == :all ? nil : val.to_i)
      end

      alias_method :list_per_page, :per_page=

      # Public: Add a column to the list.
      #
      # header  - (String) The title of the column, displayed in the table 
      #           header (default: self.attribute.titleize).
      # display - (Symbol or Proc) How to display this attribute.
      #           * If symbol, should be the name of a method in 
      #             AdminListHelper
      #           * If Proc, gets run as an instance of the class.
      #           * See AdminListHelper for more info.
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
        @columns.push column
        column
      end
      
      # Public: Define a filter for the list.
      #
      # attribute - (Symbol) The attribute on which to filter.
      # options   - (Hash) A hash of options that gets passed into Filter.new
      #
      # Returns nothing.
      def filter(attribute, options={})
        filter = Filter.new(attribute, self, options)
        @filters.push filter
        filter
      end

      private

      def default_columns
        @model.column_names - Outpost.config.excluded_list_columns
      end
    end
  end
end
