class Prngs.Models.Source extends Backbone.Model
  paramRoot: 'source'

  defaults:
    name: null
    url: null
    kind: null
    feeds: null
    popularity: null

class Prngs.Collections.SourcesCollection extends Backbone.Collection
  model: Prngs.Models.Source
  url: '/sources'
