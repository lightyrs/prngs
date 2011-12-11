Prngs.Views.Videos ||= {}

class Prngs.Views.Videos.VideoView extends Backbone.View
  template: JST["backbone/templates/videos/video"]

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
