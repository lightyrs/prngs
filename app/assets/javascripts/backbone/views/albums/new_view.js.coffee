Prngs.Views.Albums ||= {}

class Prngs.Views.Albums.NewView extends Backbone.View
  template: JST["backbone/templates/albums/new"]

  events:
    "submit #new-album": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (album) =>
        @model = album
        window.location.hash = "/#{@model.id}"

      error: (album, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
