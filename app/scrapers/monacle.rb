module Monacle

  module Feeds

    def self.squint(entry)
      puts "ORIGINAL: #{entry.andand.title}"
      entry = reduce entry
      puts "\n"
      puts "-------------------------------"
      puts entry.andand.title
      puts "+++++++++++++++++++++++++++++++"
      puts keywords(entry)
      puts "-------------------------------"
      puts "\n"
      entry
    end

    def self.reduce(entry)
      if keywords(entry).match(/news|concert reviews/i).present?
        keywords(entry).match(/review|mp3|new release|listen/i).present? ? entry : nil
      elsif sample(entry).match(/review|mp3|video|new release|listen| - /i).present?
        entry
      else
        nil
      end
    end

    def self.sample(entry)
      "#{entry.andand.title} #{keywords(entry)}"
    end

    def self.keywords(entry)
      entry.andand.categories.andand.join(" ")
    end
  end
end