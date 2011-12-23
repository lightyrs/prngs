# encoding: utf-8

module Lasso

  module Feeds

    def self.wrangle
      feeds = []
      Source.all.each do |source|
        feeds = source.feeds | feeds
      end
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
          puts "#{entry.title.gsub(/\n?/, '')}".green
          Mention.construct(source, entry)
        end
      end
    end
  end


  module Mentions

    def self.wrangle(mentions)
      mentions.each do |mention|
        begin
          robot.get(mention.url) do |page|
            dispatch(mention, page)
          end
        rescue StandardError => ex
          puts "#{ex.message}".red
        end
      end
    end

    def self.dispatch(mention, page)
      video_url = Monacle::Mentions.squint(mention, page)
      unless video_url.blank?
        begin
          video_url = scrub(video_url)
          video = VideoInfo.new(video_url, "User-Agent" => user_agent)
        rescue StandardError => ex
          puts "#{ex.message}".red
        end
        if video.valid?
          video.url = video_url
          Video.construct(mention, video)
        else
          puts "#{video_url}".red
        end
      end
    end

    def self.scrub(url)
      if url.match(/vimeo/).present?
        url.gsub(/player.|video\//, "")
      else
        url
      end
    end

    def self.user_agent
      "Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030516 Mozilla Firebird/0.6"
    end

    def self.user_agents
      ['Windows Mozilla', 'Mac Safari', 'Mac FireFox', 'Mac Mozilla', 'Linux Mozilla']
    end

    def self.robot
      Mechanize.new do |agent|
        agent.user_agent_alias = user_agents[rand(user_agents.size)]
        agent.follow_meta_refresh = true
      end
    end
  end


  module Artists

    def self.wrangle(artists)
      artists.in_groups_of(2).each do |artist_group|
        artist_group.each do |artist|
          begin
            Echonest.profile(artist)
            puts "#{artist.name}".green
          rescue StandardError => ex
            puts "#{ex.message}".red
          end
        end
        sleep 1.seconds
      end
    end
  end
end