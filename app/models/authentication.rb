class Authentication < ActiveRecord::Base

  belongs_to :user

  def self.from_omniauth(auth, current_user)
    if current_user.present?
      connect_with_omniauth(auth, current_user)
    else
      find_by_provider_and_uid(auth["provider"], auth["uid"]) || create_with_omniauth(auth)
    end
  end

  def self.create_with_omniauth(auth)
    user = User.new(:name => auth["info"]["name"])
    if auth["provider"] == "twitter"
      user.handle = auth["info"]["nickname"]
    else
      user.email = auth["extra"]["raw_info"]["email"]
    end
    user.authentications.build(
      :provider => auth["provider"],
      :uid => auth["uid"]
    )
    user.save!
    user.authentications.last
  end

  def self.connect_with_omniauth(auth, current_user)
    if previous_auth = find_by_provider_and_uid(auth["provider"], auth["uid"])
      previous_user = previous_auth.user
      previous_auth.user_id= current_user.id
      previous_auth.save!
      previous_user.destroy
    else
      current_user.authentications.build(
        :provider => auth["provider"],
        :uid => auth["uid"]
      )
    end
    if auth["provider"] == "twitter"
      current_user.handle = auth["info"]["nickname"]
    else
      current_user.email = auth["extra"]["raw_info"]["email"]
    end
    current_user.save!
    Authentication.where{user_id == current_user.id}.order{"updated_at DESC"}.limit(1).first
  end
end