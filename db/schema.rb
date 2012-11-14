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

ActiveRecord::Schema.define(:version => 20121114162514) do

  create_table "albums", :force => true do |t|
    t.string   "title"
    t.date     "release_date"
    t.integer  "artist_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "albums", ["artist_id"], :name => "index_albums_on_artist_id"
  add_index "albums", ["title"], :name => "index_albums_on_title"

  create_table "artists", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "artists", ["name"], :name => "index_artists_on_name"

  create_table "critics", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "critics", ["name"], :name => "index_critics_on_name"

  create_table "reviews", :force => true do |t|
    t.string   "link"
    t.string   "description"
    t.date     "pub_date"
    t.integer  "album_id"
    t.integer  "critic_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "reviews", ["album_id"], :name => "index_reviews_on_album_id"
  add_index "reviews", ["critic_id"], :name => "index_reviews_on_critic_id"

end
