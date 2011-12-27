class Prngs.Models.Artist extends Backbone.Model
  paramRoot: 'artist'

  defaults:
    name: null
    echonest_id: null
    images: null
    biographies: null
    popularity: null
    familiarity: null

class Prngs.Collections.ArtistsCollection extends Backbone.Collection
  model: Prngs.Models.Artist
  url: '/artists'
