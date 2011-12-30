class HomeController < ApplicationController
  
  def index
    unless cookies[:has_visited]
      cookies[:has_visited] = { :value => "true", :expires => 20.years.from_now }
      @first_time_visitor = true
    end
    @featured_video, *@popular_this_week = *Video.top(10).from_last(1.week)
  end
end