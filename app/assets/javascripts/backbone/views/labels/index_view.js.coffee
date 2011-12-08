Prngs.Views.Labels ||= {}

class Prngs.Views.Labels.IndexView extends Backbone.View
  template: JST["backbone/templates/labels/index"]

  initialize: () ->
    @options.labels.bind('reset', @addAll)

  addAll: () =>
    @options.labels.each(@addOne)

  addOne: (label) =>
    view = new Prngs.Views.Labels.LabelView({model : label})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(labels: @options.labels.toJSON() ))
    @addAll()

    return this
