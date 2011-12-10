module ApplicationHelper

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
