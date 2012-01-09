class HomeController < ApplicationController

  def index
    @popular_today = Kaminari.paginate_array(Video.from_last(1.day).top(50)).page(params[:page]).per(10)
  end
end