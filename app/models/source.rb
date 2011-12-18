class Source < ActiveRecord::Base

  has_many :mentions

  serialize :feeds

  def self.construct(name, url, kind)
    Source.find_or_create_by_name(
      :name => name,
      :url => url,
      :kind => kind
    )
  end
end
