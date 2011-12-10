module ApplicationHelper
  
  def backbone_router(resource, collection)
    <<-eos
      $(function() {
        window.router = new #{APP_NAME.capitalize}.Routers.#{resource.capitalize}Router({#{resource.downcase}:#{collection.to_json.html_safe}});
        Backbone.history.start();
      });
    eos
  end
end
