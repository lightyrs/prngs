Prngs.Views.Mentions ||= {}

class Prngs.Views.Mentions.ShowView extends Backbone.View
  template: JST["backbone/templates/mentions/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
