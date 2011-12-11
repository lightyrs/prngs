Prngs.Views.Videos ||= {}

class Prngs.Views.Videos.IndexView extends Backbone.View
  template: JST["backbone/templates/videos/index"]

  initialize: () ->
    @options.videos.bind('reset', @addAll)

  addAll: () =>
    @options.videos.each(@addOne)

  addOne: (video) =>
    view = new Prngs.Views.Videos.VideoView({model : video})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(videos: @options.videos.toJSON() ))
    @addAll()

    return this
