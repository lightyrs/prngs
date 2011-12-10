class Prngs.Models.Track extends Backbone.Model
  paramRoot: 'track'

  defaults:
    title: null
    artist_id: null
    album_id: null
    label_id: null
    rdio_url: null
    spotify_url: null

class Prngs.Collections.TracksCollection extends Backbone.Collection
  model: Prngs.Models.Track
  url: '/tracks'
