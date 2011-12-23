class Artist < ActiveRecord::Base

  has_and_belongs_to_many :videos

  validates_presence_of :name
  validates_uniqueness_of :name

  serialize :images
  serialize :biographies

  def self.construct(artist)
    Artist.find_or_create_by_name(
      :name => artist.name,
      :echonest_id => artist.id
    )
  end
end
