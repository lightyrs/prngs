class SearchesController < ApplicationController

  def search
    query = params[:video_or_sources_or_artists_name]
    videos = Video.default_search(query)
    artists = Artist.default_search(query)
    sources = Source.default_search(query)
    @results = { :videos => videos.results,
                 :artists => artists.results,
                 :sources => sources.results
               }
    render @results
  end
end