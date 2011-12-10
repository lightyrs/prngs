module Sleuth

  include ActionView::Helpers

  def self.discover_feeds
    Source.all.each do |source|
      if source_feeds = Feedbag.find(source.url)
        source_feeds = filter_feeds(source_feeds)
        source.feeds = source_feeds
        source.save
        puts "#{source_feeds.size} Content Feeds Were Found for #{source.name}"
      else
        puts "No Content Feed Was Discovered For #{source.name}"
      end
    end
  end

  def self.filter_feeds(feeds)
    feeds.reject do |feed|
      feed.match(/comment|podcast|twitter/i) != nil
    end
  end
end