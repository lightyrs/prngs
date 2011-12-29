class HomeController < ApplicationController
  
  def index
    @featured_video, *@popular_this_week = *Video.top(10).from_last(1.week)
  end
end