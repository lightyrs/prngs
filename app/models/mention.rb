class Mention < ActiveRecord::Base
  belongs_to :source
  belongs_to :author
  belongs_to :track
  belongs_to :album
end
