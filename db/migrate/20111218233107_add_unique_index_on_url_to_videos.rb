class AddUniqueIndexOnUrlToVideos < ActiveRecord::Migration
  def change
    add_index :videos, :url, :unique => true
  end
end
