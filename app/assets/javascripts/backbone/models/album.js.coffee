class Prngs.Models.Album extends Backbone.Model
  paramRoot: 'album'

  defaults:
    title: null
    artist_id: null
    label_id: null
    rdio_url: null
    spotify_url: null

class Prngs.Collections.AlbumsCollection extends Backbone.Collection
  model: Prngs.Models.Album
  url: '/albums'
