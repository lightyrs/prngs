class Prngs.Routers.VideosRouter extends Backbone.Router
  initialize: (options) ->
    @videos = new Prngs.Collections.VideosCollection()
    @videos.reset options.videos

  routes:
    "/new"      : "newVideo"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newVideo: ->
    @view = new Prngs.Views.Videos.NewView(collection: @videos)
    $("#videos").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Videos.IndexView(videos: @videos)
    $("#videos").html(@view.render().el)

  show: (id) ->
    video = @videos.get(id)

    @view = new Prngs.Views.Videos.ShowView(model: video)
    $("#videos").html(@view.render().el)

  edit: (id) ->
    video = @videos.get(id)

    @view = new Prngs.Views.Videos.EditView(model: video)
    $("#videos").html(@view.render().el)
