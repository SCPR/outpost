##
# Outpost::Model::Methods
#
# This could be renamed to something more specific
module Outpost
  module Model
    module Methods
      extend ActiveSupport::Concern
      
      def persisted_record
        @persisted_record ||= begin
          # If this record isn't persisted, return nil
          return nil if !self.persisted?
        
          # If attributes have been changed, then fetch
          # the persisted record from the database
          # Otherwise just use self
          self.changed? ? self.class.find(self.id) : self
        end
      end
    end # Methods
  end # Model
end # Outpost
