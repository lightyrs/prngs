Prngs.Views.Labels ||= {}

class Prngs.Views.Labels.ShowView extends Backbone.View
  template: JST["backbone/templates/labels/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
