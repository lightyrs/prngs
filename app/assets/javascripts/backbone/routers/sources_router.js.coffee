class Prngs.Routers.SourcesRouter extends Backbone.Router
  initialize: (options) ->
    @sources = new Prngs.Collections.SourcesCollection()
    @sources.reset options.sources

  routes:
    "/new"      : "newSource"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newSource: ->
    @view = new Prngs.Views.Sources.NewView(collection: @sources)
    $("#sources").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Sources.IndexView(sources: @sources)
    $("#sources").html(@view.render().el)

  show: (id) ->
    source = @sources.get(id)

    @view = new Prngs.Views.Sources.ShowView(model: source)
    $("#sources").html(@view.render().el)

  edit: (id) ->
    source = @sources.get(id)

    @view = new Prngs.Views.Sources.EditView(model: source)
    $("#sources").html(@view.render().el)
