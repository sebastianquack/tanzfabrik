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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140819110226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "downloads", force: true do |t|
    t.string   "description_de"
    t.string   "description_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_de_file_name"
    t.string   "attachment_de_content_type"
    t.integer  "attachment_de_file_size"
    t.datetime "attachment_de_updated_at"
    t.integer  "page_id"
    t.integer  "festival_id"
    t.string   "attachment_en_file_name"
    t.string   "attachment_en_content_type"
    t.integer  "attachment_en_file_size"
    t.datetime "attachment_en_updated_at"
  end

  create_table "event_detail_tags", force: true do |t|
    t.integer  "event_detail_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_details", force: true do |t|
    t.integer  "event_id"
    t.integer  "duration"
    t.integer  "studio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "time"
    t.integer  "repeat_mode_id"
    t.string   "custom_place"
  end

  create_table "event_types", force: true do |t|
    t.string   "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en"
  end

  add_index "event_types", ["name_de"], name: "index_event_types_on_name_de", unique: true, using: :btree

  create_table "events", force: true do |t|
    t.integer  "type_id"
    t.string   "title_de"
    t.text     "description_de"
    t.string   "warning_de"
    t.float    "price"
    t.string   "language_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title_en"
    t.text     "description_en"
    t.string   "warning_en"
    t.string   "language_en"
    t.text     "info_de"
    t.text     "info_en"
    t.boolean  "feature_on_welcome_screen"
    t.decimal  "price_regular",             precision: 4, scale: 0
    t.decimal  "price_reduced",             precision: 4, scale: 0
    t.string   "custom_type"
  end

  create_table "festival_events", force: true do |t|
    t.integer  "festival_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festivals", force: true do |t|
    t.string   "name_de"
    t.text     "description_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name_en"
    t.text     "description_en"
    t.boolean  "feature_on_welcome_screen"
    t.string   "slug"
  end

  add_index "festivals", ["slug"], name: "index_festivals_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: true do |t|
    t.string   "description"
    t.string   "license"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "studio_id"
    t.integer  "person_id"
    t.integer  "event_id"
    t.integer  "festival_id"
    t.integer  "page_id"
    t.boolean  "show_on_welcome_screen"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.text     "description_de"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_en"
  end

  create_table "pages", force: true do |t|
    t.string   "title_de"
    t.text     "content_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "title_en"
    t.text     "content_en"
    t.string   "description_de"
    t.string   "description_en"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "people", force: true do |t|
    t.string   "name"
    t.text     "bio_de"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "bio_en"
    t.boolean  "dance_intensive"
  end

  create_table "person_events", force: true do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: true do |t|
    t.string   "surname"
    t.string   "prename"
    t.string   "street"
    t.string   "city"
    t.string   "zip"
    t.string   "phone"
    t.string   "email"
    t.integer  "workshop_info"
    t.integer  "course_program"
    t.integer  "event_program"
    t.boolean  "accept_terms"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "workshop_id_1"
    t.integer  "workshop_id_2"
    t.integer  "workshop_id_3"
    t.integer  "workshop_id_4"
    t.boolean  "professional",      default: false
    t.integer  "membership_status", default: 0
  end

  create_table "repeat_modes", force: true do |t|
    t.text     "description_de"
    t.text     "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_en"
    t.string   "internal_name"
  end

  create_table "studios", force: true do |t|
    t.string   "name"
    t.text     "description_de"
    t.integer  "location_id"
    t.boolean  "rentable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description_en"
  end

  create_table "tags", force: true do |t|
    t.string   "name_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en"
    t.string   "abbr_de"
    t.string   "abbr_en"
    t.integer  "priority",   default: 0
  end

end
