namespace :hourly do

  desc "Set timestamp"
  task :begin, [:scope] => :environment do |t,args|
    puts "\nSTART: #{Time.now}\n\n"
    Rails.application.eager_load!
  end

  desc "Discover video mentions from feeds and tweets"
  task :discover_video_mentions, [:scope] => :begin do |t,args|
    puts "\nLasso::Feeds.wrangle\nSleuth::Tweets.discover\n\n"
    Lasso::Feeds.wrangle
    Sleuth::Tweets.discover
  end

  desc "Extract videos from recently created mentions"
  task :lasso_recent, [:scope] => :discover_video_mentions do |t,args|
    puts "\nLasso::Mentions.wrangle(Mention.from_last 1.hour)\n\n"
    Lasso::Mentions.wrangle(Mention.from_last 1.hour)
  end

  desc "Associate videos with artists"
  task :monacle_videos, [:scope] => :lasso_recent do |t,args|
    puts "\nMonacle::Videos.squint(Video.from_last 1.hour)\n\n"
    Monacle::Videos.squint(Video.from_last 1.hour)
  end

  desc "Get Artist info from EchoNest"
  task :lasso_artists, [:scope] => :monacle_videos do |t,args|
    puts "\nLasso::Artists.wrangle(Artist.from_last 1.hour)\n\n"
    Lasso::Artists.wrangle(Artist.from_last 1.hour)
  end

  desc "Set timestamp"
  task :init, [:scope] => :lasso_artists do |t,args|
    puts "\nEND: #{Time.now}\n\n"
    Process.exit!(true)
  end
end
