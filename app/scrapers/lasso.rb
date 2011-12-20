module Lasso

  module Artists

    def self.wrangle
      if collate last_fm_users
        puts "Success!".green
      else
        puts "There was an error wrangling the artists.".red
      end
    end

    def self.collate(users)
      artists_hash = {}
      users.each do |user|
        puts "#{user}".magenta
        10.times do |i|
          begin
            artists = LastFM::Library.get_artists({:user => user, :page => i})
            artists.values.first["artist"].each do |artist|
              artists_hash[artist["name"]] = { :lastfm_url => artist["url"], :image => artist["image"].last["#text"] }
            end
          rescue StandardError => ex
            puts "#{ex.message}".red
          end
        end
      end
      dispatch artists_hash
    end

    def self.dispatch(artists_hash)
      artists_hash.each do |artist|
        begin
          if artist.first.andand.length > 2
            Artist.construct(artist)
          end
        rescue StandardError => ex
          puts "#{ex.message}".red
        end
      end
    end

    def self.last_fm_users
      users_array = []
      users = LastFM::Group.get_members(:group => "The Hype Machine", :page => rand(100))
      users.values.first["user"].each do |user|
        users_array.push user["name"]
      end
      users_array.push("hnovick")
    end
  end

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
            puts "#{feed_url}".magenta
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

    def self.wrangle(mentions)
      mentions.each do |mention|
        begin
          robot.get(mention.url) do |page|
            dispatch(mention, page)
          end
        rescue StandardError => ex
          puts "#{ex.message}".red
          puts "#{mention.andand.url}".yellow
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
          puts "#{video_url}".magenta
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
end