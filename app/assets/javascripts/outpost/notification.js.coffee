##
# Notification
# Raise notifications from anywhere in the JS code
# Pass the $(el) to place the message into
#
class outpost.Notification
    constructor: (@wrapper, @type, @message) ->
        @el = $("<div />", class: "alert alert-#{type}").html("#{message}")

    render: ->
        @wrapper.append @el
    
    prepend: ->
        @wrapper.prepend @el
        
    # Replaces the wrapper's content with the alert
    replace: ->
        @wrapper.html @el
        
    # Delegation for jQuery: @el.is(":visible")
    isVisible: ->
        @el.is(":visible")
        
    # Delegation for jQuery: @el.show()
    show: ->
        @el.show()
        
    # Delegation for jQuery: @el.hide()
    hide: -> 
        @el.hide()
    
    # Delegation for jQuery: @el.fadeIn()
    fadeIn: (speed=400, callback=null) ->
        @el.fadeIn(speed, callback?())
    
    # Delegation for jQuery: @el.fadeOut()
    fadeOut: (speed=400, callback=null) ->
        @el.fadeOut(speed, callback?())
        
    # Delegation for jQuery: @el.detach()
    detach: ->
        @el.detach()
        
    # Delegation for jQuery: @el.remove()
    remove: ->
        @el.remove()
