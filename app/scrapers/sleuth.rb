# encoding: utf-8

module Sleuth

  module Feeds

    def self.discover
      Source.all.each do |source|
        source_feeds = filter(Feedbag.find(source.url))
        source.feeds = source_feeds
        source.save
        puts "#{source_feeds.size} Content Feeds Were Found for #{source.name}".green
      end
    end

    def self.filter(feeds)
      feeds.reject do |feed|
        feed.match(/comment|podcast|twitter/i) != nil
      end
    end
  end


  module HypeMachine

    def self.directory_url(page)
      "http://hypem.com/inc/serve_sites.php?ax=1&ts=#{Time.now.to_i}&alpha=all&page=#{page}"
    end

    def self.listing_url(fragment)
      "http://hypem.com#{fragment}?ax=1&ts=#{Time.now.to_i}"
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

    def self.construct_blogs_hash
      blogs_hash = {}
      active = true

      1000.times do |i|
        if active
          if i > 0 && i%10 == 0
            sleep 5.seconds
          end
          
          robot.get(directory_url(i)) do |page|
            if page.links.present?
              puts i.green
              page.links.each do |link|
                blogs_hash[link.text.strip!] = link.href
              end
            else
              active = false
            end
          end
          sleep 2.seconds
        else
          break
        end
      end

      blogs_hash
    end

    def self.discover_blogs
      blogs_hash = construct_blogs_hash
      blogs_hash.keys.reverse.each_with_index do |blog_name, i|
        begin
          robot.get(listing_url(blogs_hash[blog_name])) do |page|
            blog_url = page.at("h1 a:first-child")["href"]
            Source.construct(blog_name, blog_url, "Blog")
          end
        rescue StandardError => ex
          puts "#{ex.message}".red
        ensure
          if i > 0 && i%20 == 0
            sleep 5.minutes
          else
            sleep (10 + rand(10)).seconds
          end
        end
      end
    end
  end


  module Tweets

    YAML_FILE = YAML::load(File.open("#{Rails.root}/config/twitter_lists.yml"))

    def self.lists
      YAML_FILE
    end

    def self.write_yaml

      File.open("#{Rails.root}/config/twitter_lists.yml", 'w') do |file|
        file.write(lists.to_yaml)
      end
    end

    def self.discover
      i = 0
      timelines = []
      lists_count = lists.count
      lists.each do |listname, values|
        i += 1
        begin
          username = values["user"]
          listname = listname.to_s
          since_id = values["since_id"]
          timelines = timelines | list_timeline(username, listname, since_id)
        rescue
          timelines
        end
      end

      if i == lists_count
        write_yaml
      end

      timelines.compact.flatten
      #harvest(timelines.compact.flatten)
    end

    def self.harvest(grains)
      grains.each do |hash|
        if hash.keys == "mention"

        elsif hash.keys == "video"
          Video.construct(hash["video"])
        end
      end
    end

    def self.list_timeline(username, listname, since_id)
      list = Twitter.list_timeline(username, listname, :include_entities => true, :per_page => 500, :since_id => since_id)

      list.collect do |status|
        if status == list.last
          lists[listname]["since_id"] = status.id
        end

        if status.text.match(/\b(vid\w*)|\b(watch\w*)|mp4/i)
          filter(status) || nil
        end
      end
    end

    def self.filter(status)
      expanded_url = status.attrs["entities"]["urls"].pop["expanded_url"] rescue ""
      video = VideoInfo.new(expanded_url, "User-Agent" => user_agent) rescue nil

      if video && video.valid?
        # Create the video and mention
      elsif expanded_url.length > 0
        # Scrape the url for a video.
        # If one is found, create the video and mention.
      end

      # TODO: If no video or not video.valid?, scrape the url for a video.
      # If you find one create the mention and the video. 

      # screen_name = status.attrs["user"]["screen_name"].downcase
      # id_str = status.attrs["id_str"]

      # mention = Mention.create(
      #   :title => status.text,
      #   :url => "http://twitter.com/#!/#{screen_name}/status/#{id_str}",
      #   :date => status.created_at,
      #   :source_id => Source.find_or_create_by_name(
      #     :name => screen_name,
      #     :url => "http://twitter.com/#!/#{screen_name}",
      #     :kind => "Twitter"
      #   ).id
      # )
      
      # puts status.inspect
      # puts mention.inspect

      if video && video.valid?
        {"video" => video}
      else
        {"mention" => expanded_url}
      end
    end

    def self.user_agent
      "Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030516 Mozilla Firebird/0.6"
    end
  end
end
