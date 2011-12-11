module Sleuth

  module Feeds

    def self.discover
      Source.all.each do |source|
        source_feeds = filter(Feedbag.find(source.url))
        source.feeds = source_feeds
        source.save
        puts "#{source_feeds.size} Content Feeds Were Found for #{source.name}"
      end
    end

    def self.filter(feeds)
      feeds.reject do |feed|
        feed.match(/comment|podcast|twitter/i) != nil
      end
    end
  end
end