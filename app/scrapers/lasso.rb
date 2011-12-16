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
        source.feeds.andand.each do |feed_url|
          entries.push dispatch(source.id, feeds[feed_url].try(:entries))
        end
      end
    rescue StandardError => e
      puts "#{e}".red
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
end