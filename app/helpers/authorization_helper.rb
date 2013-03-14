module AuthorizationHelper
  # Public: Block out whole chunks of code based on permissions. 
  #
  # resource - (Class) The model that the user must have permission 
  #            to manage in order to see the block.
  # message  - (String) The message to display if the user isn't 
  #            authorized (default: "").
  # block    - The block that will be captured if the user is authorized.
  #            Should return a String.
  #
  # Examples
  #
  #   <%= guard Post, "You do not have permission to view this" do %>
  #     <%= @post.headline %>
  #   <% end %>
  #
  # Returns String of either the message or the captured block.
  def guard(resource, message="", &block)
    if current_user.can_manage?(resource)
      capture(&block)
    else
      message
    end
  end

  # Public: Conditionally link text based on permissions.
  #
  # resource - (Class) The model that the user must have permission
  #            to manage in order to see the link.
  # args     - Arguments to be passed directly to +link_to+ if necessary.
  #
  # Examples
  #
  #   <%= guarded_link_to Post, @post.headline, edit_post_path(@post) %>
  #
  # Returns String of either a link tag, or just the link title.
  def guarded_link_to(resource, *args)
    if current_user.can_manage?(resource)
      link_to *args
    else
      args[0] # Just the link title
    end
  end
end
