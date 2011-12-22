module Monacle

  module Feeds

    def self.squint(entry)
      reduce entry
    end

    def self.reduce(entry)
      sample(entry).match(/\b(vid\w*)|\b(watch\w*)|mp4/i).present? ? entry : nil
    end

    def self.sample(entry)
      entry.andand.title
    end

    def self.keywords(entry)
      entry.andand.categories.andand.join(" ")
    end
  end

  module Mentions

    def self.squint(mention, page)
      puts "#{mention.source.name}".yellow
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
        candidates_hash[candidate] = sample(candidate) || ""
      end
      score(mention.title, candidates_hash)
    end

    def self.score(scorer, candidates)
      candidates.each do |candidate|
        candidates[candidate.first] = scorer.pair_distance_similar candidate.last
      end
      frontrunner = candidates.values.sort.reverse.first
      candidates.key(frontrunner)
    end

    def self.sample(candidate)
      begin
        VideoInfo.new(candidate, "User-Agent" => user_agent).title
      rescue StandardError => ex
        puts "#{ex.message}".red
      end
    end

    def self.user_agent
      "Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4b) Gecko/20030516 Mozilla Firebird/0.6"
    end
  end

  module Artists

    def self.squint
      Artist.all.each do |artist|
        search = Video.solr_search do
                    fulltext %Q('#{artist.name}') do
                      phrase_fields :title => 5.0
                    end
        end
        artist.video_ids= search.andand.results.map(&:id)
        artist.save
      end
    end
  end
end