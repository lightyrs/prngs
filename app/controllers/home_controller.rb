class HomeController < ApplicationController

  def index
    @featured_video, *popular_today = *Video.from_last(1.day).top(50)
    @popular_today = Kaminari.paginate_array(popular_today).page(params[:page]).per(10)
  end
end