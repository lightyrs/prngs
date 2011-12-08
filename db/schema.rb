# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111208005013) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.integer  "artist_id"
    t.integer  "label_id"
    t.string   "rdio_url"
    t.string   "spotify_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.string   "sound"
    t.string   "rdio_url"
    t.string   "spotify_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "labels", :force => true do |t|
    t.string   "name"
    t.string   "rdio_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mentions", :force => true do |t|
    t.integer  "source_id"
    t.integer  "author_id"
    t.text     "text"
    t.string   "url"
    t.decimal  "rating",     :precision => 10, :scale => 0
    t.string   "sentiment"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.string   "title"
    t.integer  "artist_id"
    t.integer  "album_id"
    t.integer  "label_id"
    t.integer  "mention_id"
    t.string   "rdio_url"
    t.string   "spotify_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
