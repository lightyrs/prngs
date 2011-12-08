Prngs.Views.Sources ||= {}

class Prngs.Views.Sources.ShowView extends Backbone.View
  template: JST["backbone/templates/sources/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
