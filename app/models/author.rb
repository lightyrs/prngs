class Author < ActiveRecord::Base

  has_and_belongs_to_many :mentions

  validates_presence_of :name

  def self.construct(authors, kind)
    unless authors.blank?
      authors = extract_authors(authors)
      author_ids = []
      authors.each do |author|
        author_id = Author.find_or_create_by_name(:name => author.gsub(/[^0-9a-z ]/i, ''), :kind => kind).id
        author_ids.push(author_id)
      end
      author_ids
    end
  end

  private

  def self.extract_authors(authors)
    authors = authors.split(/ and |,|\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/i)
    authors.reject do |author|
      author.strip!
      author.blank? || author.split(" ").size == 1
    end
  end
end
