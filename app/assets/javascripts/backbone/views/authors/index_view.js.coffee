Prngs.Views.Authors ||= {}

class Prngs.Views.Authors.IndexView extends Backbone.View
  template: JST["backbone/templates/authors/index"]

  initialize: () ->
    @options.authors.bind('reset', @addAll)

  addAll: () =>
    @options.authors.each(@addOne)

  addOne: (author) =>
    view = new Prngs.Views.Authors.AuthorView({model : author})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(authors: @options.authors.toJSON() ))
    @addAll()

    return this
