Prngs.Views.Authors ||= {}

class Prngs.Views.Authors.EditView extends Backbone.View
  template : JST["backbone/templates/authors/edit"]

  events :
    "submit #edit-author" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (author) =>
        @model = author
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
