class Artist < ActiveRecord::Base

  has_and_belongs_to_many :videos

  validates_presence_of :name
  validates_uniqueness_of :name

  serialize :images
  serialize :biographies

  include NamedScopes::DateTime
  include NamedScopes::Popularity

  searchable do
    text    :name
    integer :popularity do
      popularity.to_f
    end
    integer :videos do
      videos.count
    end
    time    :created_at
  end


  def self.default_search(query)
    Artist.solr_search do
      fulltext query
      order_by :created_at, :desc
      order_by :popularity, :desc
      order_by :videos, :desc
      paginate :per_page => 20
    end
  end

  def self.construct(artist)
    artist = Artist.find_or_create_by_name(
               :name => artist.name,
               :echonest_id => artist.id
             )
    BeanCounter.rank(artist)
  end
end
