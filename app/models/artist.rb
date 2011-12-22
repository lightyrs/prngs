class Artist < ActiveRecord::Base

  has_and_belongs_to_many :videos

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.construct(artist)
    Artist.find_or_create_by_name(
      :name => artist.first,
      :lastfm_url => artist.last[:lastfm_url],
      :image => artist.last[:image]
    )
  end
end
