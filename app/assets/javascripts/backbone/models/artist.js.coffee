class Prngs.Models.Artist extends Backbone.Model
  paramRoot: 'artist'

  defaults:
    name: null
    sound: null
    rdio_url: null
    spotify_url: null

class Prngs.Collections.ArtistsCollection extends Backbone.Collection
  model: Prngs.Models.Artist
  url: '/artists'
