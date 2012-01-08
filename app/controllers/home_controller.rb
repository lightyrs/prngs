class HomeController < ApplicationController

  def index
    @popular_today = Kaminari.paginate_array(Video.popular_today.top(50)).page(params[:page]).per(10)
  end
end