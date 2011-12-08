Prngs.Views.Mentions ||= {}

class Prngs.Views.Mentions.EditView extends Backbone.View
  template : JST["backbone/templates/mentions/edit"]

  events :
    "submit #edit-mention" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (mention) =>
        @model = mention
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
