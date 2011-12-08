class Prngs.Routers.ArtistsRouter extends Backbone.Router
  initialize: (options) ->
    @artists = new Prngs.Collections.ArtistsCollection()
    @artists.reset options.artists

  routes:
    "/new"      : "newArtist"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newArtist: ->
    @view = new Prngs.Views.Artists.NewView(collection: @artists)
    $("#artists").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Artists.IndexView(artists: @artists)
    $("#artists").html(@view.render().el)

  show: (id) ->
    artist = @artists.get(id)

    @view = new Prngs.Views.Artists.ShowView(model: artist)
    $("#artists").html(@view.render().el)

  edit: (id) ->
    artist = @artists.get(id)

    @view = new Prngs.Views.Artists.EditView(model: artist)
    $("#artists").html(@view.render().el)
