class Prngs.Models.Video extends Backbone.Model
  paramRoot: 'video'

  defaults:
    title: null
    url: null
    video_id: null
    provider: null
    description: null
    keywords: null
    duration: null
    date: null
    thumbnail_small: null
    thumbnail_large: null
    width: null
    height: null
    popularity: null
    url_html: null

class Prngs.Collections.VideosCollection extends Backbone.Collection
  model: Prngs.Models.Video
  url: '/videos'
