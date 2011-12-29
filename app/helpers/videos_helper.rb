module VideosHelper

  def youtube_player(video)
    if video.provider.downcase == "youtube"
      "<iframe width='560' height='315' src='http://www.youtube.com/embed/#{video.video_id}' frameborder='0' allowfullscreen></iframe>".html_safe
    else
      video.title
    end
  end
end
