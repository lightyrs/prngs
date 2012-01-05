class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user

  before_filter :suggested

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def suggested
    @suggested = OpenStruct.new({
      :sources => Source.select([:id, :name, :popularity]).includes([:mentions]).most_relevant.first(5),
      :artists => Artist.select([:id, :name, :popularity]).includes([:videos]).top(5),
      :users => User.select([:id, :name]).includes([:videos]).first(5)
    })
  end


end
