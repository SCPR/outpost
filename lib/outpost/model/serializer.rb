module Outpost
  module Model
    module Serializer
      extend ActiveSupport::Concern
      
      #-------------
      # This method should be overridden
      # Don't override as_json unless you don't
      # want its baked-in goodies
      def json
        {}
      end
      
      #-------------
      # Define some defaults for as_json
      # Override +#json+ to add attributes
      # or override any of these.
      def as_json(*args)
        super.merge({
          "id"         => self.obj_key, 
          "obj_key"    => self.obj_key,
          "link_path"  => self.link_path,
          "to_title"   => self.to_title,
          "edit_path"  => self.admin_edit_path,
          "admin_path" => self.django_edit_url
        }).merge(self.json.stringify_keys!)
      end
    end # JSON
  end # Model
end # Outpost
