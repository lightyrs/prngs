Prngs.Views.Videos ||= {}

class Prngs.Views.Videos.NewView extends Backbone.View
  template: JST["backbone/templates/videos/new"]

  events:
    "submit #new-video": "save"

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
      success: (video) =>
        @model = video
        window.location.hash = "/#{@model.id}"

      error: (video, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
