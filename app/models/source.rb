class Source < ActiveRecord::Base

  has_many :mentions

  serialize :feeds
end
