class Prngs.Models.Mention extends Backbone.Model
  paramRoot: 'mention'

  defaults:
    track_id: null
    album_id: null
    source_id: null
    author_id: null
    text: null
    url: null
    rating: null
    sentiment: null
    date: null

class Prngs.Collections.MentionsCollection extends Backbone.Collection
  model: Prngs.Models.Mention
  url: '/mentions'
