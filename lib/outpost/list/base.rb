##
# Outpost::List::Base

module Outpost
  module List
    class Base
      def initialize(model)
        @model = model
        
        @columns = []
        @filers  = []
        @filters = []
        
        # Set the defaults. This is expected to get
        # overridden in the define_list block, but we can't
        # assume that it will be.
        @default_order     = List::DEFAULT_ORDER
        @default_sort_mode = List::DEFAULT_SORT_MODE
        @per_page          = List::DEFAULT_PER_PAGE
      end
      
      #---------------
      # Default order
      attr_accessor :default_order, :default_sort_mode
      attr_reader :columns, :fields, :filters, :per_page

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

      #---------------
      # This is the method that should be used to add columns
      # to a list, rather than directly creating a new Column
      #
      # Usage:
      #   define_list do
      #     column :name, header: "Full Name", display: :display_full_name
      #     column :user, header: "Associated User", display: proc { self.user.name }
      #   end
      #
      # Options:
      # * header:     (str) The title of the column, displayed in the table header.
      #               Defaults to attribute.titleize
      #
      # * display:    (sym or Proc) How to display this attribute.
      #               If symbol, should be the name of a method in AdminListHelper
      #               If Proc, gets run as an instance of the class.
      #               See AdminListHelper for more info.
      #
      def column(attribute, options={})
        column = Column.new(attribute, self, options)
        @columns.push column
        column
      end
      
      #---------------
      
      def filter(attribute, options={})
        filter = Filter.new(attribute, self, options)
        @filters.push filter
        filter
      end

      #---------------

      private

      def default_columns
        @model.column_names - Outpost.config.excluded_list_columns
      end
    end
  end
end
