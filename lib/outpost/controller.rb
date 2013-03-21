##
# Outpost::Controller
module Outpost
  module Controller
    extend ActiveSupport::Autoload
    extend ActiveSupport::Concern

    autoload :Actions
    autoload :Callbacks
    autoload :Helpers
    autoload :Authentication
    autoload :Authorization

    included do
      helper_method :list, :model, :fields
    end


    # Public: Proxy to the controller's model
    def model
      self.class.model
    end

    # Public: Proxy to the controller's list
    def list
      self.class.list
    end

    # Public: Proxy to the controller's fields
    def fields
      self.class.fields
    end


    module ClassMethods
      attr_accessor :model

      attr_writer :fields
      def fields
        @fields ||= default_fields
      end

      def list
        @list ||= define_list do
          default_columns.each do |attribute|
            column attribute
          end
        end
      end

      # Public: Define the list for this controller.
      #
      # block - A block to define the list. See List::Base for more.
      #
      # Returns nothing.
      def define_list(&block)
        @list = List::Base.new(model, &block)
      end

      # Public: Declare a controller as being a controller for Outpost.
      #
      # model - (constant) The model for this controller.
      #
      # Examples
      #
      #   class Admin::NewsStoriesController < Admin::ResourceController
      #     outpost_controller model: NewsStory
      #   end
      #
      def outpost_controller(attributes={})
        @model = attributes[:model] || find_model

        include Outpost::Controller::Actions
        include Outpost::Controller::Helpers
      end


      private

      def default_fields
        @model.column_names - Outpost.config.excluded_form_fields
      end

      def find_model
        self.name.demodulize.underscore.split("_")[0...-1].join("_").classify.constantize
      end
    end # ClassMethods
  end # Controller
end # Outpost
