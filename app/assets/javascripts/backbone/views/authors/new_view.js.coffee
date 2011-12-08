Prngs.Views.Authors ||= {}

class Prngs.Views.Authors.NewView extends Backbone.View
  template: JST["backbone/templates/authors/new"]

  events:
    "submit #new-author": "save"

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
      success: (author) =>
        @model = author
        window.location.hash = "/#{@model.id}"

      error: (author, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
