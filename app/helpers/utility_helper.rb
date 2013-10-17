module UtilityHelper
    # Public: Format a DateTime by keyword.
  #
  # date    - (DateTime) The date to format.
  # options - (Hash) A hash of options (default: {}):
  #           :with   - (String) The custom strftime string to use to
  #                     format the date.
  #           :format - (String) The format to use. Options are:
  #                     * "iso" (2012-10-11)
  #                     * "full_date" (October 11th, 2011)
  #                     * "event" (Wednesday, October 11)
  #                     * "short_date" (Oct 11, 2011)
  #           :time   - (Boolean) Whether or not to show the time.
  #
  # Examples
  #
  #   format_date(Time.now, format: "iso", time: true)
  #   # => "2013-03-13,  1:10pm"
  #
  #   format_date(Time.now, with: "%D")
  #   # => "03/13/13"
  #
  #   format_date(Time.now)
  #   # =>  "Mar 13, 2013"
  #
  # Returns String of the formatted date
  def format_date(date, options={})
    return nil if !date.respond_to?(:strftime)

    format_str = options[:with] if options[:with].present?

    format_str ||= case options[:format].to_s
      when "iso"       then "%F"
      when "full_date" then "%B #{date.day.ordinalize}, %Y"
      when "event"     then "%A, %B %-d"
      else "%b %-d, %Y"
    end

    format_str += ", %l:%M%P" if options[:time] == true

    date.strftime(format_str)
  end

  # Public: Render a block of content or fallback to a message.
  #
  # records - (Array) The list of records to check.
  # options - (Hash) A hash of options (default: {}):
  #           :message - (String) The fallback message to display.
  #           :title   - (String) The title of the collection.
  # block   - The block to capture if the collection is present.
  #
  # Examples
  #
  #   records = []
  #   any_to_list? records, message: "Empty!" do
  #     "Hidden"
  #   end
  #   # => "Empty!"
  #
  #   records = [1, 2, 3]
  #   any_to_list? records, message: "Empty!" do
  #     "Numbers!"
  #   end
  #   # => "Numbers!"
  #
  # Returns String of the captured block.
  def any_to_list?(records, options={}, &block)
    if records.present?
      return capture(&block)
    else
      if options[:message].blank?
        if options[:title].present?
          options[:message] = "There are currently no #{options[:title]}"
        else
          options[:message] = "There is nothing here to list."
        end
      end

      return options[:message].html_safe
    end
  end

  # Public: Set the first part of the page title.
  #
  # elements - Zero or more strings to prepend onto the page title.
  #            The final argument can optionally be hash:
  #            :separator - (String) The separator to use between
  #                         elements (default: " | ").
  #
  # Examples
  #
  #   set_page_title "Events", "Forum", separator: " :: "
  #   # => "Events :: Forum"
  #
  # Returns String of the first element, meant to allow you to use this
  # method to add to the page title and display a header at the same time.
  def add_to_page_title(*elements)
    @TITLE_ELEMENTS ||= []
    @TITLE_ELEMENTS += elements
    elements.first
  end

  # Public: Generate the full page title.
  #
  # last_element - (String) The string that will be appendended onto the
  #                rest of the title.
  # separator    - (String) The separator to use between the title and the last
  #                element (default: " | ").
  #
  # Examples
  #
  #   content_for(:page_title) # => "Home"
  #   page_title("KPCC", "::")
  #   # => "Home :: KPCC"
  #
  # Returns String of the full title.
  def page_title(separator=" | ")
    @TITLE_ELEMENTS.compact.join(separator).html_safe
  end

  # Public: Render pure json from a partial.
  # This helper is intended to be used to render jbuilder templates.

  # path     - (String) The path to the json partial.
  # location - (Hash) A hash of locals to pass directly to the partial
  #            (default: {}).
  #
  # Examples
  #
  #   render_json('api/private/v1/posts/collection', posts: @posts)
  #
  # Returns String of a JSON object.
  def render_json(path, locals={})
    raw(j(render(partial: path, formats: [:json], locals: locals)))
  end
end
