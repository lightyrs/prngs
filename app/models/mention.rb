class Mention < ActiveRecord::Base

  belongs_to :source
  belongs_to :track
  belongs_to :album
  belongs_to :video

  has_and_belongs_to_many :authors

  validates_presence_of :title
  validates_presence_of :url
  validates_uniqueness_of :url

  def self.construct(source, entry)
    mention = Mention.new(
                :title => entry.title,
                :text => entry.andand.content,
                :url => entry.url,
                :date => entry.published,
                :source_id => source.id
              )
    mention.author_ids= Author.construct(entry.andand.author, mention.author_kind)
    mention.save
    puts mention.authors
  end

  def author_kind
    case source.kind
    when "Blog"
      "Blogger"
    end
  end
end
