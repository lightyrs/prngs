module Monacle

  module Feeds

    def self.squint(entry)
      puts "#{reduce entry}"
    end

    def self.reduce(entry)
      puts entry.title
      sample = [ entry.andand.title, entry.andand.summary, entry.andand.categories ].join(",")
      if sample.match(/review|mp3| - /i).nil?
        nil
      end
    end
  end
end