Prngs.Views.Artists ||= {}

class Prngs.Views.Artists.ArtistView extends Backbone.View
  template: JST["backbone/templates/artists/artist"]

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
