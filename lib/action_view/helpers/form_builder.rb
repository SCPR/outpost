##
# This just adds a method to the FormBuilder which
# renders a "section" and passes in a few things:
#
# * f (which is the FormBuilder itself)
# * record (the object that the form builder is for)
# * extra (a block containing extra stuff to render)
#
# The section partial has to exist.
#
module ActionView
  module Helpers
    class FormBuilder
      def section(partial, options={}, &block)
        @template.render( 
          :partial => "/outpost/shared/sections/#{partial}", 
          :locals  => {
            :f       => self,
            :record  => self.object, 
            :options => options,
            :extra   => block_given? ? @template.capture(&block) : ""
          })
      end
      
      #----------------------
      
      def render_fields(partial, options={})
        @template.render( 
          :partial => "/outpost/shared/fields/#{partial}_fields", 
          :locals  => {
            :f       => self,
            :index   => self.object.object_id,
            :options => options
          })
      end
      
      #----------------------
      
      def link_to_add_fields(association, options={})
        association = association.to_s
        partial     = options[:partial] || association.singularize
        title       = options[:title] || "Add Another #{association.singularize.titleize}"
        
        new_object = self.object.send(association).klass.new
        id = new_object.object_id
        
        fields = self.simple_fields_for(association, new_object, child_index: id) do |nf|
          nf.render_fields(partial)
        end
                
        @template.link_to(title, "#", class: "js-add-fields", 
          data: { id: id, build_target: options[:build_target], fields: fields.gsub("\n", "") })
      end

      #----------------------
      
      def has_many_fields(association)
        partial = association.to_s.singularize
        fields  = String.new
        
        self.object.send(association).each do |obj|
          fields << self.simple_fields_for(association, obj) do |nf|
            nf.render_fields(partial)
          end
        end
        
        fields.html_safe
      end
    end
  end
end
