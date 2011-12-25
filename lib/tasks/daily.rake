namespace :daily do

  desc "Set timestamp"
  task :begin, [:scope] => :environment do |t,args|
    puts "\nSTART: #{Time.now}\n\n"
  end

  desc "Discover popularity on social networks for videos created in the last 7 days"
  task :discover_video_popularity, [:scope] => :begin do |t,args|
    puts "\nBeanCounter.rank(Video.created_this_week)\n\n"
    BeanCounter.rank(Video.created_this_week)
  end

  desc "Set timestamp"
  task :init, [:scope] => :discover_video_popularity do |t,args|
    puts "\nEND: #{Time.now}\n\n"
  end
end