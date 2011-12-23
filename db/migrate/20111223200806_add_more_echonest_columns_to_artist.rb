class AddMoreEchonestColumnsToArtist < ActiveRecord::Migration
  def change
    add_column :artists, :hotttness, :decimal
    add_column :artists, :familiarity, :decimal
  end
end
