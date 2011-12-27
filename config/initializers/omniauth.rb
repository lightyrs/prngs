Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_APP_ID, FB_SECRET, :scope => 'email,user_likes,read stream,publish_stream,publish_actions', :display => 'iframe'
  provider :twitter, TWITTER_KEY, TWITTER_SECRET
end