  ##
# Outpost::Controller
module Outpost
  module Controller
    extend ActiveSupport::Autoload
    extend ActiveSupport::Concern

    autoload :Actions
    autoload :Callbacks
    autoload :Helpers
    autoload :Ordering
    autoload :Filtering
    autoload :Preferences
    autoload :Authentication
    autoload :Authorization
    autoload :CustomErrors
    
    included do
      helper_method :list, :model, :fields
    end


    # Public: Proxy to the controller's model.
    def model
      self.class.model
    end

    # Public: Proxy to the controller's list.
    def list
      self.class.list
    end

    # Public: Proxy to the controller's fields.
    def fields
      self.class.fields
    end

    module ClassMethods
      attr_accessor :model
      attr_writer :fields

      # Public: The fields for a form.
      #
      # If no fields have been defined, then the default fields will be used.
      # Using the default fields will also set the permitted params to those
      # fields.
      #
      # Returns Array of fields.
      def fields
        @fields ||= begin
          default_fields
        end
      end

      # Public: The list for this controller.
      #
      # If no list has been defined yet, this method will
      # also define the list with the class's default columns.
      #
      # Returns the list.
      def list
        @list ||= define_list do |l|
          l.default_columns.each do |attribute|
            l.column attribute
          end
        end
      end

      # Public: Define the list for this controller.
      #
      # block - A block to define the list. See List::Base for more.
      #
      # Examples
      #
      #   define_list do |l|
      #     l.per_page = 50
      #     l.column :name
      #   end
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

        include Outpost::Controller::Helpers
        include Outpost::Controller::Callbacks
        include Outpost::Controller::Actions
        include Outpost::Controller::Ordering
        include Outpost::Controller::Filtering
        include Outpost::Controller::Preferences

        before_filter :get_record, only: [:show, :edit, :update, :destroy]
        before_filter :get_records, only: [:index]
        before_filter :authorize_resource
        before_filter :filter_records, only: [:index]
      end


      private

      def default_fields
        model.column_names - Outpost.config.excluded_form_fields
      end

      def find_model
        self.name.demodulize.underscore.split("_")[0...-1].join("_").classify.constantize
      end
    end # ClassMethods
  end # Controller
end # Outpost
