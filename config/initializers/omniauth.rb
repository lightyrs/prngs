Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FB_APP_ID, FB_SECRET, :scope => 'email, user_likes, publish_actions', :display => 'page'
  provider :twitter, TWITTER_KEY, TWITTER_SECRET

  provider :identity, on_failed_registration: lambda { |env|
    IdentitiesController.action(:new).call(env)
  }
end