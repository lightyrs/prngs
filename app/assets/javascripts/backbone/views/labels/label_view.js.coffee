Prngs.Views.Labels ||= {}

class Prngs.Views.Labels.LabelView extends Backbone.View
  template: JST["backbone/templates/labels/label"]

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
