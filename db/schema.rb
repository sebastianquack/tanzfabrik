# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_03_23_162923) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_admin_comments", id: :serial, force: :cascade do |t|
    t.string "namespace", limit: 255
    t.text "body"
    t.string "resource_id", limit: 255, null: false
    t.string "resource_type", limit: 255, null: false
    t.integer "author_id"
    t.string "author_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255, default: "", null: false
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "booking_permission_requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "status"
    t.string "type"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_booking_permission_requests_on_user_id"
  end

  create_table "booking_types", force: :cascade do |t|
    t.string "name"
    t.string "price_per"
    t.string "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "calendar_id"
    t.string "booking_number"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["calendar_id"], name: "index_bookings_on_calendar_id"
  end

  create_table "calendar_booking_types", force: :cascade do |t|
    t.string "settings"
    t.bigint "calendar_id"
    t.bigint "booking_type_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_type_id"], name: "index_calendar_booking_types_on_booking_type_id"
    t.index ["calendar_id", "booking_type_id"], name: "index_calendar_booking_types_on_calendar_id_and_booking_type_id", unique: true
    t.index ["calendar_id"], name: "index_calendar_booking_types_on_calendar_id"
  end

  create_table "calendar_events", force: :cascade do |t|
    t.bigint "calendar_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.bigint "booking_id"
    t.string "subject"
    t.string "description"
    t.string "outlook_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["booking_id"], name: "index_calendar_events_on_booking_id"
    t.index ["calendar_id"], name: "index_calendar_events_on_calendar_id"
  end

  create_table "calendars", force: :cascade do |t|
    t.string "name"
    t.string "outlook_id"
    t.bigint "studio_id"
    t.string "schedule"
    t.index ["studio_id"], name: "index_calendars_on_studio_id"
  end

  create_table "content_modules", id: :serial, force: :cascade do |t|
    t.string "module_type"
    t.integer "page_id"
    t.integer "order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "style_option"
    t.string "super_de"
    t.string "headline_de"
    t.string "sub_de"
    t.text "special_text_de"
    t.boolean "draft"
    t.text "custom_html_de"
    t.string "parameter"
    t.string "super_en"
    t.string "headline_en"
    t.string "sub_en"
    t.text "special_text_en"
    t.text "custom_html_en"
    t.string "section"
    t.string "link_href_de"
    t.string "link_href_en"
    t.string "link_title_de"
    t.string "link_title_en"
    t.string "border_bottom", default: "m"
  end

  create_table "downloads", id: :serial, force: :cascade do |t|
    t.string "description_de", limit: 255
    t.string "description_en", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attachment_de_file_name", limit: 255
    t.string "attachment_de_content_type", limit: 255
    t.integer "attachment_de_file_size"
    t.datetime "attachment_de_updated_at"
    t.integer "page_id"
    t.integer "festival_id"
    t.string "attachment_en_file_name", limit: 255
    t.string "attachment_en_content_type", limit: 255
    t.integer "attachment_en_file_size"
    t.datetime "attachment_en_updated_at"
    t.integer "festival_container_id"
    t.bigint "content_module_id"
    t.index ["content_module_id"], name: "index_downloads_on_content_module_id"
  end

  create_table "event_detail_occurrences", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "event_detail_id"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_detail_tags", id: :serial, force: :cascade do |t|
    t.integer "event_detail_id"
    t.integer "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_details", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "duration"
    t.integer "studio_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "start_date"
    t.date "end_date"
    t.time "time"
    t.integer "repeat_mode_id"
    t.string "custom_place", limit: 255
  end

  create_table "event_types", id: :serial, force: :cascade do |t|
    t.string "name_de", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name_en", limit: 255
    t.index ["name_de"], name: "index_event_types_on_name_de", unique: true
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.integer "type_id"
    t.string "title_de", limit: 255
    t.text "description_de"
    t.string "warning_de", limit: 255
    t.float "price"
    t.string "language_de", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "title_en", limit: 255
    t.text "description_en"
    t.string "warning_en", limit: 255
    t.string "language_en", limit: 255
    t.text "info_de"
    t.text "info_en"
    t.boolean "feature_on_welcome_screen"
    t.decimal "price_regular", precision: 4
    t.decimal "price_reduced", precision: 4
    t.string "custom_type_de", limit: 255
    t.date "start_date_cache"
    t.date "end_date_cache"
    t.integer "sequence", default: 0
    t.boolean "draft"
    t.string "facebook"
    t.boolean "custom_sorting", default: false
    t.boolean "no_sign_up", default: false
    t.string "signup_url"
    t.string "ticket_link_url"
    t.string "ticket_link_text_de"
    t.string "ticket_link_text_en"
    t.string "custom_type_en"
  end

  create_table "festival_containers", id: :serial, force: :cascade do |t|
    t.string "name_en", limit: 255
    t.string "name_de", limit: 255
    t.text "description_en"
    t.text "description_de"
    t.boolean "display", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festival_events", id: :serial, force: :cascade do |t|
    t.integer "festival_id"
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festival_festival_containers", id: :serial, force: :cascade do |t|
    t.integer "festival_container_id"
    t.integer "festival_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "festivals", id: :serial, force: :cascade do |t|
    t.string "name_de", limit: 255
    t.text "description_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "name_en", limit: 255
    t.text "description_en"
    t.boolean "feature_on_welcome_screen"
    t.string "slug", limit: 255
    t.boolean "draft"
    t.string "facebook"
    t.integer "page_id"
    t.string "section", default: "buehne"
    t.index ["slug"], name: "index_festivals_on_slug", unique: true
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope", limit: 255
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "images", id: :serial, force: :cascade do |t|
    t.string "description_de", limit: 255
    t.string "license", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "attachment_file_name", limit: 255
    t.string "attachment_content_type", limit: 255
    t.integer "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.integer "studio_id"
    t.integer "person_id"
    t.integer "event_id"
    t.integer "festival_id"
    t.integer "page_id"
    t.boolean "show_on_welcome_screen"
    t.integer "festival_container_id"
    t.bigint "content_module_id"
    t.string "super_de"
    t.string "super_en"
    t.string "headline_de"
    t.string "headline_en"
    t.string "link_href_de"
    t.string "link_href_en"
    t.string "link_title_de"
    t.string "link_title_en"
    t.integer "text_item_id"
    t.integer "order", default: 0
    t.boolean "logo", default: false
    t.integer "width"
    t.integer "height"
    t.boolean "logo_panel", default: false
    t.string "description_en"
    t.index ["content_module_id"], name: "index_images_on_content_module_id"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description_de"
    t.text "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description_en"
    t.integer "order", default: 0
  end

  create_table "menu_items", id: :serial, force: :cascade do |t|
    t.string "name_de"
    t.string "name_en"
    t.string "key"
    t.integer "page_id"
    t.string "ancestry"
    t.integer "position", default: 0
    t.string "anchor"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "title_de", limit: 255
    t.text "content_de"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug", limit: 255
    t.string "title_en", limit: 255
    t.text "content_en"
    t.string "description_de", limit: 255
    t.string "description_en", limit: 255
    t.float "priority", default: 0.5
    t.string "changefreq", limit: 255, default: "weekly"
    t.boolean "draft"
    t.boolean "feature_on_welcome_screen"
    t.string "feature_on_welcome_screen_note_en"
    t.string "feature_on_welcome_screen_note_de"
    t.boolean "hide_download_links"
    t.boolean "feature_on_welcome_screen_urgent", default: false
    t.integer "start_page_order", default: 0
    t.boolean "show_in_project_menu", default: false
    t.integer "project_menu_order", default: 0
    t.boolean "disable_close", default: false
    t.string "section", default: "stage"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "people", id: :serial, force: :cascade do |t|
    t.string "old_name", limit: 255
    t.text "bio_de"
    t.string "role", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.text "bio_en"
    t.boolean "dance_intensive"
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.boolean "draft"
    t.string "tags"
  end

  create_table "person_events", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "registrations", id: :serial, force: :cascade do |t|
    t.string "surname", limit: 255
    t.string "prename", limit: 255
    t.string "street", limit: 255
    t.string "city", limit: 255
    t.string "zip", limit: 255
    t.string "phone", limit: 255
    t.string "email", limit: 255
    t.integer "workshop_info"
    t.integer "course_program"
    t.integer "event_program"
    t.boolean "accept_terms"
    t.text "note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "workshop_id_1"
    t.integer "workshop_id_2"
    t.integer "workshop_id_3"
    t.integer "workshop_id_4"
    t.boolean "professional", default: false
    t.integer "membership_status", default: 0
    t.string "country", default: ""
  end

  create_table "repeat_modes", id: :serial, force: :cascade do |t|
    t.text "description_de"
    t.text "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "description_en"
    t.string "internal_name", limit: 255
  end

  create_table "studios", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description_de"
    t.integer "location_id"
    t.boolean "rentable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_file_name", limit: 255
    t.string "image_content_type", limit: 255
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.text "description_en"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.string "email"
    t.boolean "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "newsletter_1", default: false
    t.boolean "newsletter_2", default: false
    t.boolean "newsletter_3", default: false
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name_de", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name_en", limit: 255
    t.string "abbr_de", limit: 255
    t.string "abbr_en", limit: 255
    t.integer "priority", default: 0
  end

  create_table "text_items", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "content_de"
    t.text "content_en"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_text_items_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone_number", null: false
    t.string "website"
    t.string "billing_address", null: false
    t.string "preferred_language", null: false
    t.boolean "is_krk_registered", default: false, null: false
    t.boolean "is_workshop_newsletter_registered", default: false, null: false
    t.boolean "is_course_newsletter_registered", default: false, null: false
    t.text "bio", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "booking_permission_requests", "users"
  add_foreign_key "bookings", "calendars"
  add_foreign_key "calendar_booking_types", "booking_types"
  add_foreign_key "calendar_booking_types", "calendars"
  add_foreign_key "calendar_events", "bookings"
  add_foreign_key "calendar_events", "calendars"
  add_foreign_key "calendars", "studios"
end
