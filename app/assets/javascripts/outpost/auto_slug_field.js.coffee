# Find slug fields and load them up
$ ->
    for field in $("form input[name*='[slug]']")
        new outpost.AutoSlugField(field: field)

##
# AutoSlugField
#
# Takes a field and turns it into a slug on-the-fly
#
class outpost.AutoSlugField
    DefaultOptions:
        titleClass: ".sluggable"
        maxLength:  50

    constructor: (options={}) ->
        @options = _.defaults options, @DefaultOptions

        # Find the sluggable title field - if it doesn't
        # exist then we can't auto-generate a slug
        @titleField = $(@options.titleClass)[0]

        if @titleField
            @slugField  = $ @options.field
            @maxLength  = @options.maxLength
            @button     = $ JST['outpost/templates/slug_generate_button']()

            # If we found a matching field,
            # render the generate button and add it after the slug field
            @slugField.after(@button)
            @button.on
                click: (event) =>
                    @updateSlug($(@titleField).val())
                    event.preventDefault()
                    false

        true

    #------------------

    updateSlug: (value) ->
        @slugField.val @slugify(value)

    #------------------

    slugify: (str) ->
        str.toLowerCase()
           .replace(/\s+/g, "-")     # Spaces -> `-`
           .replace(/-{2,}/g, '-')   # Fix accidental double-hyphens
           .replace(/[^\w\-]+/g, '') # Remove non-word characters/hyphen
           .replace(/^-+/, '')       # Trim hyphens from beginning
           .substring(0, @maxLength) # Just the first 50 characters
           .replace(/-+$/, '')       # Trim hyphens from end
