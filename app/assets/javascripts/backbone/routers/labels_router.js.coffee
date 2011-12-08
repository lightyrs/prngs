class Prngs.Routers.LabelsRouter extends Backbone.Router
  initialize: (options) ->
    @labels = new Prngs.Collections.LabelsCollection()
    @labels.reset options.labels

  routes:
    "/new"      : "newLabel"
    "/index"    : "index"
    "/:id/edit" : "edit"
    "/:id"      : "show"
    ".*"        : "index"

  newLabel: ->
    @view = new Prngs.Views.Labels.NewView(collection: @labels)
    $("#labels").html(@view.render().el)

  index: ->
    @view = new Prngs.Views.Labels.IndexView(labels: @labels)
    $("#labels").html(@view.render().el)

  show: (id) ->
    label = @labels.get(id)

    @view = new Prngs.Views.Labels.ShowView(model: label)
    $("#labels").html(@view.render().el)

  edit: (id) ->
    label = @labels.get(id)

    @view = new Prngs.Views.Labels.EditView(model: label)
    $("#labels").html(@view.render().el)
