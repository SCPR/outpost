##
# Naming
#
# Some naming helpers.
#
# Example:
#
#   Outpost::Helpers::Naming.to_class("outpost/news_stories")
#
module Outpost
  module Helpers
    module Naming
      extend self
      
      # These helpers expect a controller param, 
      # such as 'outpost/news_stories'
      # "outpost/news_stories" => NewsStory
      def to_class(controller)
        controller.singularize.camelize.demodulize.constantize
      end
    end # Naming
  end # Helpers
end # Outpost
