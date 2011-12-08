Prngs.Views.Sources ||= {}

class Prngs.Views.Sources.EditView extends Backbone.View
  template : JST["backbone/templates/sources/edit"]

  events :
    "submit #edit-source" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (source) =>
        @model = source
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
