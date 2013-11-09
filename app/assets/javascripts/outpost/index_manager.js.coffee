##
# IndexManager
#
# Load up special things in the index pages.
#
class outpost.IndexManager
    DefaultOptions:
        cellFinder:    "*[data-updatable='true']"

    constructor: (@baseUrl, options={}) ->
        @options = _.defaults options, @DefaultOptions

        for cell in $(@options.cellFinder)
            new outpost.QuickEditCell $(cell), @baseUrl

##
# QuickEditCell
#
# Adds the ability to quick-edit any attribute from the index page.
# Looks for fields with 'data-updatable="true"'
#
class outpost.QuickEditCell
    defaults:
        formTemplate:   JST["outpost/templates/data_field"]
        attribute:      "data-attribute"
        id:             "data-id"
        highlightColor: "#dff0d8"
        highlightTime:  2000

    constructor: (@el, baseUrl, options={}) ->
        @options = _.defaults options, @defaults

        # Check values
        @value = null
        @keyup = false

        # Attributes
        @attribute = @el.attr(@options.attribute)
        @id        = @el.attr(@options.id)
        @url       = "#{baseUrl}/#{@id}"

        @ajaxOptions =
            dataType: 'json'
            url: @url

        @el.on
            click: (event) => @buildForm()

        @el.on
            keyup: (event) =>
                if event.keyCode == 13
                    @keyup = true
                    @updateData(event)
            blur: (event) =>
                if not @keyup
                    @updateData(event)
        , 'input'

    #-------------

    buildForm: (event) ->
        $.ajax _.extend @ajaxOptions,
            type: "GET"
            success: (data, status, xhr) =>
                @value = data[@attribute]
                @el.html(@options.formTemplate attribute: @attribute, id: @id, inputValue: @value)
                @el.find("input").focus()

    #-------------

    updateData: (event) ->
        input = $(event.target)
        value = input.val()

        if value is @value
            @el.html(value)
            @keyup = false
            return

        $.ajax _.extend @ajaxOptions,
            type: "PUT"
            data:
                data_point:
                    data_value: value
            success: (data, status, xhr) =>
                @el.html(value)
                @el.effect "highlight", { color: @options.highlightColor }, @options.highlightTime
                @keyup = false
