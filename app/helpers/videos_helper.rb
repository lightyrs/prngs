module VideosHelper

  def youtube_player(video)
    if video.provider.downcase == "youtube"
      "<iframe width='560' height='315' src='http://www.youtube.com/embed/#{video.video_id}?wmode=transparent' frameborder='0' allowfullscreen></iframe>".html_safe
    elsif video.provider.downcase == "vimeo"
      "<iframe src='http://player.vimeo.com/video/#{video.video_id}?title=0&amp;byline=0&amp;portrait=0&amp;color=0fb0d4&amp;wmode=transparent' width='560' height='315' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>".html_safe
    else
      video.title
    end
  end
end
