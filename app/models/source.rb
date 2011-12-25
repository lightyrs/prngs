class Source < ActiveRecord::Base

  has_many :mentions

  serialize :feeds

  def self.construct(name, url, kind)
    source = Source.find_or_create_by_name(
               :name => name,
               :url => url,
               :kind => kind
             )
    BeanCounter.rank(source)
  end
end
