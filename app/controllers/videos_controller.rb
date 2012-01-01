class VideosController < ApplicationController

  autocomplete :video_and_sources_and_artists_search, { :video => [:title], :source => [:name], :artist => [:name] }
end
