Prngs.Views.Labels ||= {}

class Prngs.Views.Labels.NewView extends Backbone.View
  template: JST["backbone/templates/labels/new"]

  events:
    "submit #new-label": "save"

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
      success: (label) =>
        @model = label
        window.location.hash = "/#{@model.id}"

      error: (label, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
