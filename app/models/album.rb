class Album < ActiveRecord::Base

  belongs_to :artist
  belongs_to :label

  has_many :mentions
end
