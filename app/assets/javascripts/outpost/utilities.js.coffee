class outpost.Utilities
    # Prevent forms from submitting when the "Enter"
    # key is pressed inside of a text field
    # Pass in an optional form ID to restrict it just to that form.
    @preventEnterFromSubmittingForm: (formId='') ->
        $("form#{formId} input[type=text]").on
            keydown: (event) ->
                key = event.keyCode || event.which

                if key == 13 # Enter
                    event.stopPropagation()
                    event.preventDefault()
                    false
