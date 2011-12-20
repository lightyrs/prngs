class Video < ActiveRecord::Base

  has_many :mentions
  belongs_to :artist

  validates_presence_of :url
  validates_presence_of :video_id
  validates_uniqueness_of :video_id

  def self.construct(mention, video)
    video = Video.find_or_create_by_url(
              :title => video.title,
              :url => video.url,
              :video_id => video.video_id,
              :provider => video.provider,
              :description => video.description,
              :keywords => video.keywords,
              :duration => video.duration,
              :date => video.date,
              :thumbnail_small => video.thumbnail_small,
              :thumbnail_large => video.thumbnail_large,
              :width => video.width,
              :height => video.height
            )
    mention.video_id = video.id
    mention.save
  end
end
