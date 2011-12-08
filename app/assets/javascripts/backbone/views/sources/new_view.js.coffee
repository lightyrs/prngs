Prngs.Views.Sources ||= {}

class Prngs.Views.Sources.NewView extends Backbone.View
  template: JST["backbone/templates/sources/new"]

  events:
    "submit #new-source": "save"

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
      success: (source) =>
        @model = source
        window.location.hash = "/#{@model.id}"

      error: (source, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
