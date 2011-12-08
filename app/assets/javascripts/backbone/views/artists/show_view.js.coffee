Prngs.Views.Artists ||= {}

class Prngs.Views.Artists.ShowView extends Backbone.View
  template: JST["backbone/templates/artists/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
