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

ActiveRecord::Schema.define(version: 20170110111905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body"
    t.string   "resource_id",   limit: 255, null: false
    t.string   "resource_type", limit: 255, null: false
    t.integer  "author_id"
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "assets", force: :cascade do |t|
    t.string   "storage_uid",          limit: 255
    t.string   "storage_name",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "storage_width"
    t.integer  "storage_height"
    t.float    "storage_aspect_ratio"
    t.integer  "storage_depth"
    t.string   "storage_format",       limit: 255
    t.string   "storage_mime_type",    limit: 255
    t.string   "storage_size",         limit: 255
  end

  create_table "downloads", force: :cascade do |t|
    t.string   "description_de",             limit: 255
    t.string   "description_en",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_de_file_name",    limit: 255
    t.string   "attachment_de_content_type", limit: 255
    t.integer  "attachment_de_file_size"
    t.datetime "attachment_de_updated_at"
    t.integer  "page_id"
    t.integer  "festival_id"
    t.string   "attachment_en_file_name",    limit: 255
    t.string   "attachment_en_content_type", limit: 255
    t.integer  "attachment_en_file_size"
    t.datetime "attachment_en_updated_at"
    t.integer  "festival_container_id"
  end

  create_table "event_detail_occurrences", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "event_detail_id"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_detail_tags", force: :cascade do |t|
    t.integer  "event_detail_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_details", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "duration"
    t.integer  "studio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "time"
    t.integer  "repeat_mode_id"
    t.string   "custom_place",   limit: 255
  end

  create_table "event_tags", id: false, force: :cascade do |t|
    t.integer  "id",         default: "nextval('event_tags_id_seq'::regclass)", null: false
    t.integer  "event_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "name_de",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en",    limit: 255
  end

  add_index "event_types", ["name_de"], name: "index_event_types_on_name_de", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "type_id"
    t.string   "title_de",                  limit: 255
    t.text     "description_de"
    t.string   "warning_de",                limit: 255
    t.float    "price"
    t.string   "language_de",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",           limit: 255
    t.string   "image_content_type",        limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title_en",                  limit: 255
    t.text     "description_en"
    t.string   "warning_en",                limit: 255
    t.string   "language_en",               limit: 255
    t.text     "info_de"
    t.text     "info_en"
    t.boolean  "feature_on_welcome_screen"
    t.decimal  "price_regular",                         precision: 4
    t.decimal  "price_reduced",                         precision: 4
    t.string   "custom_type",               limit: 255
    t.date     "start_date_cache"
    t.date     "end_date_cache"
    t.integer  "sequence",                                            default: 0
    t.boolean  "draft"
    t.string   "facebook"
  end

  create_table "festival_containers", force: :cascade do |t|
    t.string   "name_en",        limit: 255
    t.string   "name_de",        limit: 255
    t.text     "description_en"
    t.text     "description_de"
    t.boolean  "display",                    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festival_events", force: :cascade do |t|
    t.integer  "festival_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festival_festival_containers", force: :cascade do |t|
    t.integer  "festival_container_id"
    t.integer  "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festivals", force: :cascade do |t|
    t.string   "name_de",                   limit: 255
    t.text     "description_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",           limit: 255
    t.string   "image_content_type",        limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name_en",                   limit: 255
    t.text     "description_en"
    t.boolean  "feature_on_welcome_screen"
    t.string   "slug",                      limit: 255
    t.boolean  "draft"
    t.string   "facebook"
  end

  add_index "festivals", ["slug"], name: "index_festivals_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",               null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "description",             limit: 255
    t.string   "license",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name",    limit: 255
    t.string   "attachment_content_type", limit: 255
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer  "studio_id"
    t.integer  "person_id"
    t.integer  "event_id"
    t.integer  "festival_id"
    t.integer  "page_id"
    t.boolean  "show_on_welcome_screen"
    t.integer  "festival_container_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "description_de"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_en"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "title_de",                          limit: 255
    t.text     "content_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                              limit: 255
    t.string   "title_en",                          limit: 255
    t.text     "content_en"
    t.string   "description_de",                    limit: 255
    t.string   "description_en",                    limit: 255
    t.float    "priority",                                      default: 0.5
    t.string   "changefreq",                        limit: 255, default: "weekly"
    t.boolean  "draft"
    t.boolean  "feature_on_welcome_screen"
    t.string   "feature_on_welcome_screen_note_en"
    t.string   "feature_on_welcome_screen_note_de"
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "old_name",           limit: 255
    t.text     "bio_de"
    t.string   "role",               limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "bio_en"
    t.boolean  "dance_intensive"
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.boolean  "draft"
  end

  create_table "person_events", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "surname",           limit: 255
    t.string   "prename",           limit: 255
    t.string   "street",            limit: 255
    t.string   "city",              limit: 255
    t.string   "zip",               limit: 255
    t.string   "phone",             limit: 255
    t.string   "email",             limit: 255
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
    t.boolean  "professional",                  default: false
    t.integer  "membership_status",             default: 0
  end

  create_table "repeat_modes", force: :cascade do |t|
    t.text     "description_de"
    t.text     "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description_en"
    t.string   "internal_name",  limit: 255
  end

  create_table "studios", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.text     "description_de"
    t.integer  "location_id"
    t.boolean  "rentable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name",    limit: 255
    t.string   "image_content_type", limit: 255
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.text     "description_en"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string   "email"
    t.boolean  "status"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "newsletter_1", default: false
    t.boolean  "newsletter_2", default: false
    t.boolean  "newsletter_3", default: false
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name_de",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name_en",    limit: 255
    t.string   "abbr_de",    limit: 255
    t.string   "abbr_en",    limit: 255
    t.integer  "priority",               default: 0
  end

  create_table "text_items", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "content_de"
    t.text     "content_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "text_items", ["name"], name: "index_text_items_on_name", unique: true, using: :btree

end
