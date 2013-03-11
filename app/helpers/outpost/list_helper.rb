module Outpost
  module ListHelper
    # Public: Maps the passed-in sort mode (asc, desc) to the appropriate
    # Bootstrap Glyphicons (icon-arrow-up, icon-arrow-down respectively)
    #
    # sort_mode - (String) The sort mode ("asc", "desc").
    #
    # Examples
    #
    #   <i class="<%= sort_mode_icon('asc') %>">
    #   # => <i class="icon-arrow-up">
    #
    # Returns String of the icon class.
    def sort_mode_icon(sort_mode)
      case sort_mode
      when "desc" then "icon-arrow-down"
      when "asc"  then "icon-arrow-up"
      end
    end

    # Public: Which sort mode to switch to. Useful for creating links to 
    # switch the sort mode or change the list order.
    #
    # column            - (Outpost::Column) The column on which the sort 
    #                     will be performed.
    # current_order     - (String) The attribute that is currently being
    #                     ordered.
    # current_sort_mode - (String) The current sort mode ("asc", "desc").
    #
    # Examples
    #   
    #   <%= link_to column.header, request.parameters.merge({
    #      :sort_mode => switch_sort_mode(
    #          column, current_order, current_sort_mode
    #      )
    #   }) %>
    #
    # Returns String of the sort mode, "asc" or "desc"
    def switch_sort_mode(column, current_order, current_sort_mode)
      if column.attribute == current_order
        case current_sort_mode
        when "asc"  then "desc"
        when "desc" then "asc"
        else column.default_sort_mode
        end
      else
        column.default_sort_mode
      end
    end

    # Public: Generate a CSS class for the column. If the column represents 
    # an association, the class will be "column-association".
    #
    # model     - (Class) The ActiveRecord model.
    # attribute - (String) The attribute for this column.
    #
    # Examples
    #
    #   <tr class="<%= column_type_class(BlogEntry, 'created_at') %>">
    #   # => <tr class="column-datetime">
    #
    # Returns String to be used as a CSS class.
    def column_type_class(model, attribute)
      if column = model.columns_hash[attribute]
        "column-#{column.type}"
      else
        "column-association"
      end
    end

    # Public: Generate a CSS class for this attribute
    #
    # attribute - (String) The attribute.
    #
    # Examples
    #
    #   <td class="<%= column_attribute_class('created_at') %>">
    #   # => <td class="column-created_at">
    #
    # Returns String to be used as a CSS class.
    def column_attribute_class(attribute)
      "column-#{attribute}"
    end
  end
end
