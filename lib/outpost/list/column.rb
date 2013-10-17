module Outpost
  module List
    class Column
      attr_accessor \
        :attribute,
        :display,
        :position,
        :list,
        :quick_edit,
        :sortable,
        :default_order_direction,
        :_display_helper,
        :header

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

        @default_order_direction =
          attributes[:default_order_direction] || List::DEFAULT_ORDER_DIRECTION
      end
    end
  end
end
