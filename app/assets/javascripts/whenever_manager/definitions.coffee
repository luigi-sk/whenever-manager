
$(->
  blurTextarea = (e)->
    source = $(e.target)
    target = source.parent().find("pre code")
    target.html(hljs.highlightAuto(source.val()).value)
    source.hide()
    target.show()

  showTextarea = (el)->
    source = $(el)
    source.parent().find("textarea").show()
    source.parent().find("textarea").focus()
#    source.hide()

  $(document).click((e)->
    if $(e.target).parents(".schedule_code").length > 0
      target = $(e.target).parents(".schedule_code pre")
      showTextarea(target)
      e.preventDefault()
  )
  $(".schedule_code textarea").blur(blurTextarea)
)