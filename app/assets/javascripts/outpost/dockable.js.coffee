$(document).ready ->
  dockables = $("fieldset.form-block.dockable")
  dock      = $("#dock")
  if dock.length > 0
    $.each dockables, (idx, dockableElement) ->
      dockable = $(dockableElement)
      dismissControl = dockable.find("legend a.dismiss-control")
      dockControl    = dockable.find("legend a.dock-control")
      dockControl.on "click", (e) ->
        e.stopPropagation()
        unless dockable.hasClass("docked")
          dockable.before "<div class='dockable-placeholder' data-dockable-id='#{dockable.attr('id')}'></div>"
          dockControl.hide()
          dismissControl.show()
          dockable.addClass "docked"
          dockable.prependTo dock
      dismissControl.on "click", (e) ->
        e.stopPropagation()
        if dockable.hasClass("docked")
          placeholder = $(".dockable-placeholder[data-dockable-id='" + (dockable.attr('id')) + "']")
          placeholder.before dockable
          placeholder.remove()
          dismissControl.hide()
          dockable.removeClass "docked"
          dockControl.show()