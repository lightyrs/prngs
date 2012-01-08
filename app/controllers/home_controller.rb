class HomeController < ApplicationController

  respond_to :html, :js

  def index
    @popular_today = Kaminari.paginate_array(Video.popular_today.top(50)).page(params[:page]).per(10)

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