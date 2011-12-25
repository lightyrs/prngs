class Artist < ActiveRecord::Base

  has_and_belongs_to_many :videos

  validates_presence_of :name
  validates_uniqueness_of :name

  serialize :images
  serialize :biographies

  scope :recently_created, lambda { where("created_at >= ?", 1.hours.ago) }

  def self.construct(artist)
    artist = Artist.find_or_create_by_name(
               :name => artist.name,
               :echonest_id => artist.id
             )
    BeanCounter.rank(artist)
  end
end
