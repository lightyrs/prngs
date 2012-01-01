class HomeController < ApplicationController
  
  def index
    @featured_video, *@popular_this_week = *Video.top(10).from_last(1.week)
    @suggested = OpenStruct.new({
      :sources => Source.most_relevant.first(5),
      :artists => Artist.top(5),
      :users => User.first(5)
    })
  end
end