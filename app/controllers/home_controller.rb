class HomeController < ApplicationController

  respond_to :html, :js

  def index
    @featured_video, *popular_today = *Video.from_last(1.day).top(50)
    @popular_today = Kaminari.paginate_array(popular_today).page(params[:page]).per(10)

    respond_to do |format|
      format.html {
        if request.xhr?
          render :partial => "home/videos", :popular_today => @popular_today
        else
          render :index
        end
      }
    end
  end
end