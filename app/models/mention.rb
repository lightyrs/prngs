class Mention < ActiveRecord::Base

  belongs_to :source
  belongs_to :author
  belongs_to :track
  belongs_to :album
  belongs_to :video

  def self.construct(source, entry)
    Mention.create(
      :title => entry.title,
      :text => entry.andand.content,
      :url => entry.url,
      :date => entry.published,
      :source_id => source,
      :author_id => Author.find_or_create_by_name(entry.andand.author).id
    )
  end
end
