namespace :scrapers do

  desc "Start"
  task :timestamp, [:scope] => :environment do |t,args|
    Rails.logger.debug("START: #{Time.now}")
    Rails.application.eager_load!
  end

  desc "Discover sources from the Hype Machine"
  task :discover_sources, [:scope] => :timestamp do |t,args|
    Sleuth::HypeMachine.discover_blogs
  end

  desc "Discover feeds from sources"
  task :discover_feeds, [:scope] => :discover_sources do |t,args|
    Sleuth::Feeds.discover
  end

  desc "Discover artists"
  task :discover_artists, [:scope] => :discover_feeds do |t,args|
    Lasso::Artists.wrangle
  end

  desc "Discover video mentions from feeds"
  task :discover_video_mentions, [:scope] => :discover_artists do |t,args|
    Lasso::Feeds.wrangle
  end

  desc "Generate Data"
  task :init, [:scope] => :discover_video_mentions do |t,args|
    Rails.logger.debug("END: #{Time.now}")
  end
end