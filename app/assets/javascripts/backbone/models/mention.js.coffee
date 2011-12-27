class Prngs.Models.Mention extends Backbone.Model
  paramRoot: 'mention'

  defaults:
    source_id: null
    text: null
    url: null
    date: null
    video_id: null
    title: null

class Prngs.Collections.MentionsCollection extends Backbone.Collection
  model: Prngs.Models.Mention
  url: '/mentions'
