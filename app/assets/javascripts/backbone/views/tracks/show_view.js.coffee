Prngs.Views.Tracks ||= {}

class Prngs.Views.Tracks.ShowView extends Backbone.View
  template: JST["backbone/templates/tracks/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
