##
# FieldManager
#
# A simple class that listens for certain events
# and does things to forms
#
class outpost.FieldManager
    constructor: ->
        
        $("fieldset.form-block legend").on
            click: (event) ->
                target = $(@)
                target.siblings(".fields").toggle()
                target.siblings(".notification").toggle()

        # Add fields
        $(".js-add-fields").on
            click: (event) ->
                event.preventDefault()

                target = $(@)
                time   = new Date().getTime()
                regexp = new RegExp(target.data('id'), 'g')
                fields = $(target.data('fields').trim().replace(regexp, time))
                
                if buildTarget = target.data('build-target')
                    $(buildTarget).append fields
                else
                    target.before(fields)
                    
                # Build any special fields.
                # TODO: Can we accomplish this with triggers?
                outpost.DateTimeInput.buildDateTimeInputs(fields)
                outpost.DateTimeInput.buildDateInputs(fields)
                $("select", fields).select2
                    placeholder: " "
                    allowClear: true
