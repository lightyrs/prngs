class Source < ActiveRecord::Base

  has_many :mentions

  validates_presence_of :name
  validates_uniqueness_of :name

  serialize :feeds

  include NamedScopes::DateTime
  include NamedScopes::Popularity

  searchable do
    text    :name
    integer :popularity
    integer :mentions do
      mentions.map(&:video).compact.count
    end
    time    :created_at
  end


  def videos
    mentions.map(&:video).compact.uniq
  end

  def relevance
    popularity.to_i + (videos.count*5)
  end

  def self.most_relevant
    Source.all.delete_if{|s| s.relevance == 0}.sort_by(&:relevance).reverse
  end

  def self.default_search(query)
    Source.solr_search do
      fulltext query
      order_by :created_at, :desc
      order_by :popularity, :desc
      order_by :mentions, :desc
      paginate :per_page => 20
    end
  end

  def self.construct(name, url, kind)
    source = Source.find_or_create_by_name(
               :name => name,
               :url => url,
               :kind => kind
             )
    BeanCounter.rank(source)
  end
end
