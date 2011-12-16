class Author < ActiveRecord::Base

  has_many :mentions
end
