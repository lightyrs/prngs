module Monacle

  module Feeds

    def self.squint(entry)
      reduce entry
    end

    def self.reduce(entry)
      sample(entry).match(/\b(vid\w*)|\b(watch\w*)|mp4/i).present? ? entry : nil
    end

    def self.sample(entry)
      "#{entry.andand.title} #{keywords(entry)}"
    end

    def self.keywords(entry)
      entry.andand.categories.andand.join(" ")
    end
  end

  module Mentions

    def self.squint(mention, page)
      reduce(mention, page)
    end

    def self.reduce(mention, page)
      elect(mention, nominate(page))
    end

    def self.nominate(page)
      candidates = []
      page.links.andand.each do |link|
        candidates.push link.href
      end
      page.iframes.andand.each do |iframe|
        candidates.push iframe.attributes["src"]
      end
      candidates.delete_if do |url|
        url.nil? || url.match(/youtube|vimeo/).nil?
      end
    end

    def self.elect(mention, candidates)
      candidates_hash = {}
      candidates.each do |candidate|
        candidates_hash[candidate] = sample(candidate)
      end
      sorted_candidates = score(mention.title, candidates_hash.values)
      candidates_hash.key(sorted_candidates.first)
    end

    def self.score(scorer, samples)
      scorer = StringScore.new(scorer)
      scorer.sort_by_score(samples)
    end

    def self.sample(candidate)
      words = VideoInfo.new(candidate).title.split(" ")
      words.any? ? words.max{ |a,b| a.length <=> b.length } : ""
    end
  end
end