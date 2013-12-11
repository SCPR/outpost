##
# Notification
# Raise notifications from anywhere in the JS code
# Pass the $(el) to place the message into
#
class outpost.Notification
    constructor: (@wrapper, @type, @message) ->
        @el = @_buildElement()

    # Alias for #append
    render: ->
        @append()

    # Replaces the element.
    # This is useful if you've changed the message or type.
    rerender: ->
        newEl = @_buildElement()
        @el.replaceWith(newEl)
        @el = newEl

    # Append the element to the wrapper.
    append: ->
        @wrapper.append @el

    # Prepend the element to the wrapper.
    prepend: ->
        @wrapper.prepend @el

    # Replaces the wrapper's content with the alert
    replace: ->
        @wrapper.html @el

    # Delegation for jQuery: @el.html("new text")
    html: (html) ->
        @el.html(html)

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


    # Builds an element based on the attributes.
    _buildElement: ->
        $("<div />", class: "alert alert-#{@type}").html("#{@message}")
