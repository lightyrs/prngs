Prngs.Views.Videos ||= {}

class Prngs.Views.Videos.EditView extends Backbone.View
  template : JST["backbone/templates/videos/edit"]

  events :
    "submit #edit-video" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (video) =>
        @model = video
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
