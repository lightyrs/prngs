module Lasso

  module Feeds

    def self.wrangle
      feeds = []
      Source.all.each do |source|
        feeds = source.feeds | feeds
      end
      collate Feedzirra::Feed.fetch_and_parse(feeds)
    end

    def self.collate(feeds)
      Source.all.each do |source|
        source.feeds.each do |feed_url|
          dispatch feeds[feed_url].andand.entries
        end
      end
    end

    def self.dispatch(entries)
      entries.andand.each do |entry|
        Monacle::Feeds.squint(entry)
      end
    end
  end
end