class Prngs.Models.Label extends Backbone.Model
  paramRoot: 'label'

  defaults:
    name: null
    rdio_url: null

class Prngs.Collections.LabelsCollection extends Backbone.Collection
  model: Prngs.Models.Label
  url: '/labels'
