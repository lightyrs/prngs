class Prngs.Routers.TracksRouter extends Backbone.Router
  initialize: (options) ->
    @tracks = new Prngs.Collections.TracksCollection()
    @tracks.reset options.tracks

  routes:
    "/new"      : "newTrack"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newTrack: ->
    @view = new Prngs.Views.Tracks.NewView(collection: @tracks)
    $("#tracks").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Tracks.IndexView(tracks: @tracks)
    $("#tracks").html(@view.render().el)

  show: (id) ->
    track = @tracks.get(id)

    @view = new Prngs.Views.Tracks.ShowView(model: track)
    $("#tracks").html(@view.render().el)

  edit: (id) ->
    track = @tracks.get(id)

    @view = new Prngs.Views.Tracks.EditView(model: track)
    $("#tracks").html(@view.render().el)
