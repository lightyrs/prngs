# encoding: utf-8

module ApplicationHelper

  include TweetButton

  TweetButton.default_tweet_button_options = {
    :via => "prngs",
    :related => "lightyrs",
    :count => "horizontal"
  }

  def flash_messages
    unless flash.blank? or flash.nil?
      output = ""
      flash.each do |name, msg|
        output += "<div class='alert-message flash #{name}'>
          <a class='close' href='#'> ×</a>
          <p><strong>#{name.capitalize}</strong> #{msg}</p>
        </div>"
      end
      raw output
    end
  end

  def body_class
    controller.controller_name || ""
  end

  def backbone_router(resource, collection)
    <<-eos
      $(function() {
        window.router = new #{APP_NAME.capitalize}.Routers.#{resource.capitalize}Router({#{resource.downcase}:#{collection.to_json.html_safe}});
        Backbone.history.start();
      });
    eos
  end
end
