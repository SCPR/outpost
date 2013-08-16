# Bootstrap things

# Scrollspy has to be initiated here, 
# instead of via data- attributes, 
# otherwise it's buggy. I don't know why.
offset = 160
nav    = "#form-nav"

$ ->
    # Select2
    # Set a blank placeholder for all selects.
    # Also allow clearing for any option.
    # If you don't want the "clear" option on a certain select element,
    # add the `include_blank: false` option to the rails
    # helper.
    #
    # Note: This also gets called in field_manager.
    # TODO: Make it so we don't have to call it twice.
    $("select").not('[data-disable-select2="true"]').select2
        placeholder: " "
        allowClear: true

    # Affix
    # Fix the width for all of these elements
    $('[data-spy="affix"]').each ->
        $(@).width $(@).width()

    # For table headers, we want them to act cool so we have 
    # to treat them special. First fix the widths of the "th"
    # elements. Then make the top margin of the table the 
    # same as the height of the header. Then move the header
    # up its height in pixels to give the appearance of
    # sitting on top.
    $('table.index-list thead').each ->
        $(@).width $(@).width()

        $('th', @).each -> $(@).width $(@).width()
        height = $(@).height()
        $(@).closest("table").css("margin-top": height)

        $(@).addClass("ready")
        $(@).css("top": -height)

    $('table.index-list thead').affix
        offset: 65

    # Scrollspy
    $spy = $("body").scrollspy
        target: nav
        offset: offset

    # Since we have some fixed elements at the
    # top of the screen, we have to offset the
    # anchors when they're clicked in the form
    # nav.
    $("#{nav} li a").on
        click: (event) ->
            event.preventDefault()
            href = $(@).attr('href')
            window.location.hash = href
            $(href)[0].scrollIntoView()
            window.scrollBy(0, -offset + 80)
            false

    # Make highlighted TH's clickable
    # TODO Move this into a better place
    $("th.header-highlighted, th.header-sortable").each ->
        if href = $(".js-sort-link", @).attr("href")
            $(@).addClass("clickable")
            $(@).on click: (event) ->
                window.location = href

    true
