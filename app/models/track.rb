class Track < ActiveRecord::Base
  belongs_to :artist
  belongs_to :album
  belongs_to :label
end
