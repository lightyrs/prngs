namespace :scrapers do

  desc "Start"
  task :timestamp, [:scope] => :environment do |t,args|
    Rails.logger.debug("START: #{Time.now}")
  end

  desc "Discover sources from the Hype Machine"
  task :discover_sources, [:scope] => :timestamp do |t,args|
    Sleuth::HypeMachine.discover_blogs
  end

  desc "Discover feeds from sources"
  task :discover_feeds, [:scope] => :discover_sources do |t,args|
    Sleuth::Feeds.discover
  end

  desc "Discover video mentions from feeds"
  task :discover_video_mentions, [:scope] => :discover_feeds do |t,args|
    Lasso::Feeds.wrangle
  end

  desc "Generate Data"
  task :init, [:scope] => :discover_video_mentions do |t,args|
    Rails.logger.debug("END: #{Time.now}")
  end
end