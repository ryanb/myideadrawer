# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081019213034) do

  create_table "activities", :force => true do |t|
    t.string   "message"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["project_id"], :name => "index_activities_on_project_id"
  add_index "activities", ["user_id"], :name => "index_activities_on_user_id"

  create_table "code_snippets", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.text     "content"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "code_snippets", ["project_id"], :name => "index_code_snippets_on_project_id"

  create_table "color_swatches", :force => true do |t|
    t.integer  "palette_id"
    t.string   "hex"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "color_swatches", ["palette_id"], :name => "index_color_swatches_on_palette_id"

  create_table "links", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "links", ["project_id"], :name => "index_links_on_project_id"

  create_table "notes", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["project_id"], :name => "index_notes_on_project_id"

  create_table "open_id_authentication_associations", :force => true do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url"
    t.binary  "secret"
  end

  create_table "open_id_authentication_nonces", :force => true do |t|
    t.integer "timestamp",  :null => false
    t.string  "server_url"
    t.string  "salt",       :null => false
  end

  create_table "palettes", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "palettes", ["project_id"], :name => "index_palettes_on_project_id"

  create_table "photos", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "photos", ["project_id"], :name => "index_photos_on_project_id"

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "last_activity_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "token"
    t.boolean  "show_code_snippets"
    t.boolean  "show_palettes"
    t.boolean  "show_links"
    t.boolean  "show_notes"
    t.boolean  "show_photos"
    t.boolean  "show_screenshots"
  end

  add_index "projects", ["token"], :name => "index_projects_on_token"
  add_index "projects", ["user_id"], :name => "index_projects_on_user_id"

  create_table "screenshots", :force => true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.string   "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "screenshots", ["project_id"], :name => "index_screenshots_on_project_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "openid_url"
  end

  add_index "users", ["openid_url"], :name => "index_users_on_openid_url"

end
