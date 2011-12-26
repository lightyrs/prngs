class Source < ActiveRecord::Base

  has_many :mentions

  validates_presence_of :name
  validates_uniqueness_of :name

  serialize :feeds

  include NamedScopes::DateTime
  include NamedScopes::Popularity


  def self.construct(name, url, kind)
    source = Source.find_or_create_by_name(
               :name => name,
               :url => url,
               :kind => kind
             )
    BeanCounter.rank(source)
  end

  def self.most_popular_overall
    order("popularity DESC").first
  end
end
