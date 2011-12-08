Prngs.Views.Authors ||= {}

class Prngs.Views.Authors.AuthorView extends Backbone.View
  template: JST["backbone/templates/authors/author"]

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
