# Set an element to display for any input(e.g. select) depending on its value.
# Typically, this element would contain some options, but it could be
# pretty much anything.

class outpost.ContextOptions
    defaults: {}

    constructor: (@options={}) ->
        _.defaults @options, @defaults

        # Elements
        @form          = $ @options.form
        @containers    = $.map @options.containers, (c) -> {value: c.value, container: $(c.container)}
        @valueField    = $ @options.valueField,     @form

        @valueField.on
            change: (event) =>
                @getValue()
                @toggleVisibility()

        @originalStatus = @getValue()
        @toggleVisibility()

    toggleVisibility: ->
        val = @getValue()
        _.each @containers, (c) =>
            if val is c.value
                c.container.show()
            else
                c.container.hide()

    getValue: ->
        @status = $("option:selected", @valueField).val()