class Prngs.Models.Author extends Backbone.Model
  paramRoot: 'author'

  defaults:
    name: null
    url: null
    kind: null

class Prngs.Collections.AuthorsCollection extends Backbone.Collection
  model: Prngs.Models.Author
  url: '/authors'
