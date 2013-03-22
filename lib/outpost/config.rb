##
# Outpost::Config
#
# Define configuration for Outpost
module Outpost
  class Config
    DEFAULTS = {
      :title_attributes           => [:name, :title],
      :excluded_form_fields       => ["id", "created_at", "updated_at"],
      :excluded_list_columns      => [],
      :user_class                 => "User",
      :authentication_attribute   => :email,
      :preferences                => [:order, :sort_mode]
    }
    
    # Pass a block to this method to define the configuration
    # If no block is passed, config will be defaults
    def self.configure
      config = new
      yield config if block_given?
      Outpost.config = config
    end
    
    # An array of models that should show up
    attr_writer :registered_models
    def registered_models
      @registered_models || []
    end
    
    attr_writer :preferences
    def preferences
      @preferences || DEFAULTS[:preferences]
    end

    attr_writer :user_class
    def user_class
      @user_class || DEFAULTS[:user_class]
    end

    # Which attribute to use to authenticate
    attr_writer :authentication_attribute
    def authentication_attribute
      @authentication_attribute || DEFAULTS[:authentication_attribute]
    end

    # Which attributes to look at for `to_title`
    attr_writer :title_attributes
    def title_attributes
      (@title_attributes ||= DEFAULTS[:title_attributes]) | [:simple_title]
    end
    
    # Ignore these attributes when building a basic form
    attr_writer :excluded_form_fields
    def excluded_form_fields
      (@excluded_form_fields ||= []) | DEFAULTS[:excluded_form_fields]
    end
    
    # Ignore these attributes when building a basic list
    attr_writer :excluded_list_columns
    def excluded_list_columns
      (@excluded_list_columns ||= []) | DEFAULTS[:excluded_list_columns]
    end
  end
end
