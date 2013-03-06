##
# Outpost::Controller
#
module Outpost
  module Controller
    extend ActiveSupport::Autoload
    extend ActiveSupport::Concern

    autoload :Actions
    autoload :Callbacks
    autoload :Helpers

    #----------------------

    included do
      helper_method :list, :model, :fields
    end

    #----------------------

    def model
      self.class.model
    end

    #----------------------

    def list
      self.class.list
    end

    def fields
      self.class.fields
    end

    #----------------------
    #----------------------

    module ClassMethods
      attr_accessor :model
      attr_writer :fields
      attr_reader :list

      #----------------------
    
      def fields
        @fields ||= default_fields
      end

      #----------------------
      # Get the List object for this controller.
      #
      # If `list` hasn't yet been defined,
      # then we'll figure out some sensible columns to use.
      # Otherwise use the defined list.


      #----------------------
      # Define the list for this controller.
      #
      # Pass a block.
      #
      def define_list(&block)
        @list = List::Base.new(model)
        @list.instance_eval(&block)
      end

      #----------------------
      # Declare a controller as being a controller for
      # Outpost.
      #
      # Attributes:
      #
      # * model - (constant) the model for this controller
      #
      # Example:
      #
      #   class Admin::NewsStoriesController < Admin::ResourceController
      #     outpost_controller model: NewsStory
      #   end
      #
      def outpost_controller(attributes={})
        @model = attributes[:model]

        include Outpost::Controller::Actions
        include Outpost::Controller::Helpers
      end

      #----------------------

      private

      def default_fields
        @model.column_names - Outpost.config.excluded_form_fields
      end
    end # ClassMethods
  end # Controller
end # Outpost
