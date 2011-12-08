Prngs.Views.Labels ||= {}

class Prngs.Views.Labels.EditView extends Backbone.View
  template : JST["backbone/templates/labels/edit"]

  events :
    "submit #edit-label" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (label) =>
        @model = label
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
