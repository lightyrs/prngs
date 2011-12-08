Prngs.Views.Mentions ||= {}

class Prngs.Views.Mentions.NewView extends Backbone.View
  template: JST["backbone/templates/mentions/new"]

  events:
    "submit #new-mention": "save"

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
      success: (mention) =>
        @model = mention
        window.location.hash = "/#{@model.id}"

      error: (mention, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
