##
# Filter
#
module Outpost
  module List
    class Filter
      attr_accessor :attribute, :collection, :title
      
      #---------------
      
      def initialize(attribute, list, options={})
        @attribute  = attribute
        @title      = options[:title] || attribute.to_s.titleize
        @list       = list
        
        # Set the collection
        collection = options[:collection]
        @collection = begin
          case collection
          when NilClass
            # TODO Automatically detect column type
          when Proc
            collection
          when Symbol
            send("_#{collection}_collection")
          end
        end
      end
      
      #---------------
      
      private
      
      def _boolean_collection
        -> { [["Yes", 1], ["No", 0]] }
      end
    end
  end
end
