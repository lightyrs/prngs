class Prngs.Models.Video extends Backbone.Model
  paramRoot: 'video'

  defaults:
    artist_id: null
    title: null
    url: null
    kind: null

class Prngs.Collections.VideosCollection extends Backbone.Collection
  model: Prngs.Models.Video
  url: '/videos'
