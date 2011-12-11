Prngs.Views.Videos ||= {}

class Prngs.Views.Videos.ShowView extends Backbone.View
  template: JST["backbone/templates/videos/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
