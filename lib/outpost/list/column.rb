module Outpost
  module List
    class Column
      attr_accessor :attribute, :display, :position, :list, :quick_edit, :sortable, :default_sort_mode
      attr_writer :header

      alias_method :quick_edit?, :quick_edit
      alias_method :sortable?, :sortable

      #------------------
      
      def initialize(attribute, list, attributes={})
        @attribute = attribute.to_s
        @list      = list
        @position  = @list.columns.size

        @header     = attributes[:header]
        @display    = attributes[:display]
        @quick_edit = !!attributes[:quick_edit]
        @sortable   = !!attributes[:sortable]

        @default_sort_mode = attributes[:default_sort_mode] || "asc"
      end
      
      #------------------
      
      def header
        @header ||= @attribute.titleize 
      end
    end
  end
end
