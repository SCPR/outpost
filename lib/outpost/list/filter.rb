##
# Filter
#
module Outpost
  module List
    class Filter
      BOOLEAN_COLLECT = [["Yes", 1], ["No", 0]]

      attr_accessor :attribute, :collection, :title, :list
      
      def initialize(attribute, list, options={})
        @attribute  = attribute.to_s
        @list       = list
        @title      = options[:title] || @attribute.titleize
        
        collection = options[:collection]
        @collection = begin
          case collection
          when NilClass
            # TODO Automatically detect column type
          when Proc
            collection
          when Symbol
            send "_#{collection}_collection"
          end
        end
      end
      

      private
      
      def _boolean_collection
        -> { BOOLEAN_COLLECT }
      end
    end
  end
end
