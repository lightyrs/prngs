class Prngs.Routers.AuthorsRouter extends Backbone.Router
  initialize: (options) ->
    @authors = new Prngs.Collections.AuthorsCollection()
    @authors.reset options.authors

  routes:
    "/new"      : "newAuthor"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newAuthor: ->
    @view = new Prngs.Views.Authors.NewView(collection: @authors)
    $("#authors").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Authors.IndexView(authors: @authors)
    $("#authors").html(@view.render().el)

  show: (id) ->
    author = @authors.get(id)

    @view = new Prngs.Views.Authors.ShowView(model: author)
    $("#authors").html(@view.render().el)

  edit: (id) ->
    author = @authors.get(id)

    @view = new Prngs.Views.Authors.EditView(model: author)
    $("#authors").html(@view.render().el)
