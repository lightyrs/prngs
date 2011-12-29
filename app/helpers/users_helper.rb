module UsersHelper

  def connection_status(provider, current_user)
    if current_user.authentications.map(&:provider).include? provider
      "Connected with #{provider.capitalize}"
    else
      "<a href='/auth/#{provider}'>Connect with #{provider.capitalize}</a>".html_safe
    end
  end

  def user_avatar(current_user)
    image_url = current_user.facebook_avatar || current_user.twitter_avatar
    image_tag image_url, :alt => current_user.name
  end
end