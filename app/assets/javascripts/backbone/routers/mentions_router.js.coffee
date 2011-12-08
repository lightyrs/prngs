class Prngs.Routers.MentionsRouter extends Backbone.Router
  initialize: (options) ->
    @mentions = new Prngs.Collections.MentionsCollection()
    @mentions.reset options.mentions

  routes:
    "/new"      : "newMention"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newMention: ->
    @view = new Prngs.Views.Mentions.NewView(collection: @mentions)
    $("#mentions").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Mentions.IndexView(mentions: @mentions)
    $("#mentions").html(@view.render().el)

  show: (id) ->
    mention = @mentions.get(id)

    @view = new Prngs.Views.Mentions.ShowView(model: mention)
    $("#mentions").html(@view.render().el)

  edit: (id) ->
    mention = @mentions.get(id)

    @view = new Prngs.Views.Mentions.EditView(model: mention)
    $("#mentions").html(@view.render().el)
