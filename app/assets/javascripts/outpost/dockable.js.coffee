$(document).ready ->
  dockables = $("fieldset.form-block.dockable")
  dock      = $("#dock")
  if dock.length > 0
    $.each dockables, (idx, dockableElement) ->
      dockable = $(dockableElement)
      dismissControl = dockable.find("legend a.dismiss-control")
      dockControl    = dockable.find("legend a.dock-control")
      dockControl.on "click", (e) ->
        dockable.before "<div class='dockable-placeholder' data-dockable-id='#{dockable.attr('id')}'></div>"
        dockControl.hide()
        dismissControl.show()
        dockable.prependTo dock
      dismissControl.on "click", (e) ->
        placeholder = $(".dockable-placeholder[data-dockable-id='" + (dockable.attr('id')) + "']")
        placeholder.before dockable
        placeholder.remove()
        dismissControl.hide()
        dockControl.show()
