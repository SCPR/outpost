##
# Naming
#
# Some methods for naming things, and stuff
#
module Outpost
  module Model
    module Naming
      extend ActiveSupport::Concern
      
      module ClassMethods
        # NewsStory => News Story
        def to_title
          self.name.demodulize.titleize
        end
      end
      
      #-------------
      # Convert any AR object into a human-readable title
      # Tries the attributes in config.title_attributes
      # And falls back to "BlogEntry #99"
      #
      # This allows us to get a human-readable title regardless
      # of what an object's "title" attribute happens to be.
      #
      # To define your own set of attributes, do so with the config
      #
      #   Outpost.config.title_attributes = [:title, :full_name]
      #
      # The :simple_title method will automatically be added to the array
      # and acts as the fallback.
      #
      # Usage:
      #
      #   story = NewsStory.last #=> NewsStory(id: 900, title: "Cool Story, Bro")
      #   blog  = Blog.last      #=> Blog(id: 5, name: "Some Blog")
      #   photo = Photo.last     #=> Photo(id: 10, url: "http://photos.com/kitty")
      #
      #   story.to_title  #=> "Cool Story, Bro"
      #   blog.to_title   #=> "Some Blog"
      #   photo.to_title  #=> "Photo #10"
      #
      def title_method
        @title_method ||= begin
          attributes = Outpost.config.title_attributes
          attributes.find { |a| self.respond_to?(a) }
        end
      end
      
      #-------------
      
      def to_title
        @to_title ||= self.send(self.title_method)
      end
      
      #-------------
      
      def simple_title
        @simple_title ||= begin
          if self.new_record?
            "New #{self.class.to_title}"
          else
            "#{self.class.to_title} ##{self.id}"
          end
        end
      end
    end # Naming
  end # Model
end # Outpost
