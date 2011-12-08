Prngs.Views.Sources ||= {}

class Prngs.Views.Sources.SourceView extends Backbone.View
  template: JST["backbone/templates/sources/source"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
