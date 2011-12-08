Prngs.Views.Artists ||= {}

class Prngs.Views.Artists.IndexView extends Backbone.View
  template: JST["backbone/templates/artists/index"]

  initialize: () ->
    @options.artists.bind('reset', @addAll)

  addAll: () =>
    @options.artists.each(@addOne)

  addOne: (artist) =>
    view = new Prngs.Views.Artists.ArtistView({model : artist})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(artists: @options.artists.toJSON() ))
    @addAll()

    return this
