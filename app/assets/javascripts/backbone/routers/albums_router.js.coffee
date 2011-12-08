class Prngs.Routers.AlbumsRouter extends Backbone.Router
  initialize: (options) ->
    @albums = new Prngs.Collections.AlbumsCollection()
    @albums.reset options.albums

  routes:
    "/new"      : "newAlbum"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newAlbum: ->
    @view = new Prngs.Views.Albums.NewView(collection: @albums)
    $("#albums").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Albums.IndexView(albums: @albums)
    $("#albums").html(@view.render().el)

  show: (id) ->
    album = @albums.get(id)

    @view = new Prngs.Views.Albums.ShowView(model: album)
    $("#albums").html(@view.render().el)

  edit: (id) ->
    album = @albums.get(id)

    @view = new Prngs.Views.Albums.EditView(model: album)
    $("#albums").html(@view.render().el)
