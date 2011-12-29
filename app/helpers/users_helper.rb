module UsersHelper

  def connection_status(provider, current_user)
    if current_user.authentications.map(&:provider).include? provider
      "Connected with #{provider}"
    else
      "<a href='/auth/#{provider}'>Connect with #{provider}</a>".html_safe
    end
  end
end