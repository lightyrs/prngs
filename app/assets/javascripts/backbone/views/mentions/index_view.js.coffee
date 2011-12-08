Prngs.Views.Mentions ||= {}

class Prngs.Views.Mentions.IndexView extends Backbone.View
  template: JST["backbone/templates/mentions/index"]

  initialize: () ->
    @options.mentions.bind('reset', @addAll)

  addAll: () =>
    @options.mentions.each(@addOne)

  addOne: (mention) =>
    view = new Prngs.Views.Mentions.MentionView({model : mention})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(mentions: @options.mentions.toJSON() ))
    @addAll()

    return this
