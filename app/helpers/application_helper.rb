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

  def ajax_render(el, target)
    script = <<-eos
      <script>
        $(function() {
          $('.pagination span a').live('ajax:beforeSend', function(event, xhr, settings){
            xhr.setRequestHeader('accept', 'text/html');
          });
          $('#{el}').live('ajax:beforeSend', function(xhr, settings) {
            var $target = $(xhr.target);
            $target.css("color", "transparent").spin(Prngs.opts.spinner);
          }).live('ajax:success', function(evt, data, status, xhr) {
            $('#{target}').replaceWith(data);
          });
        });
      </script>
    eos
    script.html_safe
  end
end
