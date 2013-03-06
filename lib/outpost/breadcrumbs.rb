##
# Outpost::Breadcrumbs
#
# Super-simple breadcrumbs for you and me.
# Include it into a controller
# 
# Arguments:
# Pairs of strings. Title of breadcrumb, Path
#
# Usage:
# In the controller:
#
#   class PostsController < ApplicationController
#     def new
#       breadcrumb "New", admin_new_post_path
#       @post = Post.new
#     end
#   end
#
# This module then makes the "breadcrumbs" helper
# available to you (and me), which can be used in
# your view:
#
#   <% breadcrumbs.each do |crumb| %>
#     <%= link_to crumb.title, crumb.link %>
#   <% end %>
#
# You can also define multiple breadcrumbs at once.
# Every 2 arguments is a new breadcrumb:
#
#   breadcrumb "Edit", admin_edit_post_path(@post.id), @post.title, admin_post_path(@post)
#
# Don't want the crumb to be linked? Just leave the 
# second argument off, or +nil+ if you're defining
# multiple breadcrumbs:
#
#   breadcrumb "Edit", nil, @post.title
#
module Outpost
  class Breadcrumb
    attr_accessor :title, :link
  end
  
  #---------------
  
  module Breadcrumbs
    extend ActiveSupport::Concern
    
    included do
      attr_reader :breadcrumbs
    
      if self < ActionController::Base
        helper_method :breadcrumbs
      end
    end
    
    #--------------
    # Use this method to add breadcrumbs.
    # See Outpost::Breadcrumbs 
    # for usage.
    def breadcrumb(*args)
      @breadcrumbs ||= []
      
      args.each_slice(2).map do |pair|
        crumb       = Outpost::Breadcrumb.new
        crumb.title = pair[0]
        crumb.link  = pair[1]
        
        @breadcrumbs.push crumb
      end
    end
  end
end
