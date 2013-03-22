module Outpost
  module List
    class Column
      attr_accessor :attribute, :display, :position, :list, :quick_edit, 
        :sortable, :default_sort_mode, :_display_helper, :header

      alias_method :quick_edit?, :quick_edit
      alias_method :sortable?, :sortable
      
      def initialize(attribute, list, attributes={})
        @attribute = attribute.to_s
        @list      = list
        @position  = @list.columns.size

        @header     = attributes[:header] || @attribute.titleize
        @display    = attributes[:display]
        @quick_edit = !!attributes[:quick_edit]
        @sortable   = !!attributes[:sortable]

        @default_sort_mode = attributes[:default_sort_mode] || List::DEFAULT_SORT_MODE
      end
    end
  end
end
