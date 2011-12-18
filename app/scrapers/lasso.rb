module Lasso

  module Feeds

    def self.wrangle
      feeds = Source.all.map(&:feeds)
      if collate Feedzirra::Feed.fetch_and_parse(feeds)
        puts "Success!".green
      else
        puts "There was an error wrangling the feeds.".red
      end
    end

    def self.collate(feeds)
      entries = []
      Source.all.each do |source|
        begin
          source.feeds.andand.each do |feed_url|
            entries.push dispatch(source, feeds[feed_url].try(:entries))
          end
        rescue StandardError => e
          puts "#{e}".red
        end
      end
    end

    def self.dispatch(source, entries)
      entries.andand.each do |entry|
        entry = Monacle::Feeds.squint(entry)
        unless entry.nil? || entry.andand.title.blank? || entry.andand.url.blank?
          puts "#{entry.title.gsub(/\n?/, '')}".magenta
          puts "#{entry.url}".yellow
          Mention.construct(source, entry)
        end
      end
    end
  end

  module Mentions

    def self.user_agents
      ['Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla']
    end

    def self.robot
      Mechanize.new do |agent|
        agent.user_agent_alias = user_agents[rand(user_agents.size)]
        agent.follow_meta_refresh = true
      end
    end

    def self.wrangle
      Mention.all.each do |mention|
        robot.get(mention.url) do |page|
          dispatch(mention, page)
        end
      end
    end

    def self.dispatch(mention, page)
      video_url = Monacle::Mentions.squint(mention, page)
      unless video_url.nil?
        puts "#{video_url}".magenta
        video = VideoInfo.new(video_url)
        video["url"] = video_url
        Video.construct(mention, video)
      end
    end
  end
end