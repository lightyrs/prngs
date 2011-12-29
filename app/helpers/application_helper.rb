# encoding: utf-8

module ApplicationHelper

  def flash_messages
    unless flash.blank? or flash.nil?
      output = ""
      flash.each do |name, msg|
        output += "<div class='alert-message flash #{name}'>
          <a class='close' href='#'> ×</a>
          <p><strong>#{name.capitalize}</strong> #{msg}</p>
        #{javascript_include_tag 'application/flash.js'}</div>"
      end
      raw output
    end
  end

  include TweetButton

  TweetButton.default_tweet_button_options = {
    :via => "prngs",
    :related => "lightyrs",
    :count => "horizontal"
  }

  def body_class
    controller.controller_name || ""
  end

  def primary_nav
    html = ""
    SITE_SECTIONS.map do |section|
      html += "<li><a href=#{nav_links(section)}>#{section}</a></li>"
    end
    html
  end

  def nav_links(section)
    eval("#{section.downcase}_path")
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
