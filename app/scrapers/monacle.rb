module Monacle

  module Feeds

    def self.squint(entry)
      reduce entry
    end

    def self.reduce(entry)
      sample(entry).match(/\b(vid\w*)|watch|mp4/i).present? ? entry : nil
    end

    def self.sample(entry)
      "#{entry.andand.title} #{keywords(entry)}"
    end

    def self.keywords(entry)
      entry.andand.categories.andand.join(" ")
    end
  end
end