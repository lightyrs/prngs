namespace :hourly do

  desc "Set timestamp"
  task :begin, [:scope] => :environment do |t,args|
    Rails.logger.debug("START: #{Time.now}")
  end

  desc "Discover video mentions from feeds"
  task :discover_video_mentions, [:scope] => :begin do |t,args|
    Lasso::Feeds.wrangle
  end

  desc "Extract videos from recently created mentions"
  task :lasso_recent, [:scope] => :discover_video_mentions do |t,args|
    Lasso::Mentions.wrangle(Mention.recently_created)
  end

  desc "Set timestamp"
  task :init, [:scope] => :lasso_recent do |t,args|
    Rails.logger.debug("END: #{Time.now}")
  end
end