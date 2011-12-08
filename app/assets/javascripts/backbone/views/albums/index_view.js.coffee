Prngs.Views.Albums ||= {}

class Prngs.Views.Albums.IndexView extends Backbone.View
  template: JST["backbone/templates/albums/index"]

  initialize: () ->
    @options.albums.bind('reset', @addAll)

  addAll: () =>
    @options.albums.each(@addOne)

  addOne: (album) =>
    view = new Prngs.Views.Albums.AlbumView({model : album})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(albums: @options.albums.toJSON() ))
    @addAll()

    return this
