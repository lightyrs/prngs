# encoding: utf-8

module ApplicationHelper

  include TweetButton

  TweetButton.default_tweet_button_options = {
    :via => "prngs",
    :related => "lightyrs",
    :count => "horizontal"
  }

  def body_class
    controller.controller_name || ""
  end

  def flash_messages
    if flash.present?
      output = ""
      flash.each do |name, msg|
        output += "<div class='alert-message flash #{name}' data-alert='#{name}'>
          <a class='close' href='#'> ×</a>
          <p><strong>#{name.capitalize}</strong> #{msg}</p>
        </div>#{ javascript_include_tag "application/flash" }"
      end
      raw output
    end
  end
end
