
$ ->
    # Initialize a FieldCounter for any field that asks for it.
    for field in $("form .field-counter")
        el        = $(field)
        target    = el.attr("data-target")
        fuzziness = el.attr("data-fuzziness")
        new outpost.FieldCounter(el, target: target, fuzziness: fuzziness)

##
# FieldCounter
# To turn a field into a field counter, add three attributes:
#
#   class="field-counter"
#   data-target="50"        # Perfect length
#   data-fuzziness="10"     # Lee-way in either direction (inclusive)
#
# Anything spanning the range of
#
#   `(target - fuzziness) through (target + fuzziness)`
#
# (inclusive) will be considered "in-range". Everything else is
# "out of range". By default, this class will use the Twitter Bootstrap
# notification classes, but that can be overridden.
#
class outpost.FieldCounter
    DefaultOptions:
        target:          145                      # Perfect length
        fuzziness:       20                       # Lee-way (in either direction, inclusive)
        inRangeClass:    "alert alert-success"
        outOfRangeClass: "alert alert-warning"
        counterClass:    "counter-notify"
        counterWrapper:  ".controls"             # The element to which the counter will be prepended
        counterStyle:    "padding: 3px; margin: 0 0 2px 0;"

    constructor: (@el, options={}) ->
        @options = _.defaults options, @DefaultOptions

        # Setup elements
        @field   = $("input, textarea", @el)
        @counterEl = $("<div />", class: @options.counterClass, style: @options.counterStyle)
        $(@options.counterWrapper, @el).prepend @counterEl

        # Setup attributes
        @count     = 0
        @target    = parseInt(@options.target)
        @fuzziness = parseInt(@options.fuzziness)
        @rangeLow  = @target - @fuzziness
        @rangeHigh = @target + @fuzziness

        @inRangeClass    = @options.inRangeClass
        @outOfRangeClass = @options.outOfRangeClass

        # Register listeners
        @field.on
            keyup: (event) =>
                @updateCount($(event.target).val().length)

        @el.on
            updateCounter: (event, count) =>
                @updateText(count)
                @updateColor(count)

        # Set the count on initialize
        @updateCount(@field.val().length)

    #--------------

    inRange: ->
        @rangeLow <= @count and @count <= @rangeHigh

    #--------------

    updateCount: (length) ->
        @count = length
        @el.trigger "updateCounter", @count

    #--------------

    updateText: (count) ->
        @counterEl.html("<strong>Optimal Length:</strong> #{count} of #{@target} (+/- #{@fuzziness})")

    #--------------

    updateColor: (count) ->
        if @inRange()
            @counterEl.removeClass(@outOfRangeClass)
            @counterEl.addClass(@inRangeClass)
        else
            @counterEl.removeClass(@inRangeClass)
            @counterEl.addClass(@outOfRangeClass)


