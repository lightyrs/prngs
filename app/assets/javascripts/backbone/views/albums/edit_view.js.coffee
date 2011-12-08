Prngs.Views.Albums ||= {}

class Prngs.Views.Albums.EditView extends Backbone.View
  template : JST["backbone/templates/albums/edit"]

  events :
    "submit #edit-album" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (album) =>
        @model = album
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
