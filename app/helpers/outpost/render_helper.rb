module Outpost
  module RenderHelper
    # Public: Render the table wrapper.
    #
    # records - (Array) Records that are being represented in the table.
    # model   - (Class) The ActiveRecord model for this table.
    # block   - The rendered table. Should return a String.
    #
    # Examples:
    #
    #   <%= list_table @posts, Post do %>
    #     <table>...</table>
    #   <% end %>
    #
    # Returns a String of the table, or a message if no records are present.
    def list_table(records, model, &block)
      render '/outpost/shared/list_table', model: model, records: records, table: capture(&block)
    end

    # Public: Render a fieldset.
    #
    # title - (String) The title of this fieldset. If +nil+ is passed
    #         in, then no legend will be rendered, and the fieldset block
    #         will not be added to the sidebar sections.
    # block - The body of the fieldset. Should return a String.
    #
    # Examples
    #
    #   <%= form_block "Publishing" do %>
    #     <input type="text">...
    #   <% end %>
    #
    # Returns a String of the fieldset.
    #
    def form_block(title="", &block)
      render "/outpost/shared/form_block", title: title, body: capture(&block)
    end
  end
end
