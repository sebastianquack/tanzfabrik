# This migration comes from active_storage (originally 20170806125915)
class CreateActiveStorageTables < ActiveRecord::Migration[6.0]
  def up

    create_table :active_storage_blobs, if_not_exists: true do |t|
      t.string   :key,        null: false
      t.string   :filename,   null: false
      t.string   :content_type
      t.text     :metadata
      t.bigint   :byte_size,  null: false
      t.string   :checksum,   null: false
      t.datetime :created_at, null: false

    end

    if !index_exists? :active_storage_blobs, [ :key ], unique: true
      add_index :active_storage_blobs, [ :key ], unique: true
    end

    if !index_exists? :active_storage_attachments, [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
      create_table :active_storage_attachments, if_not_exists: true do |t|
        t.string     :name,     null: false
        t.references :record,   null: false, polymorphic: true, index: false
        t.references :blob,     null: false

        t.datetime :created_at, null: false

        t.foreign_key :active_storage_blobs, column: :blob_id
      end

      add_index :active_storage_attachments, [ :record_type, :record_id, :name, :blob_id ], name: "index_active_storage_attachments_uniqueness", unique: true
    end 

    return if foreign_key_exists?(:active_storage_attachments, column: :blob_id)

    if table_exists?(:active_storage_blobs)
      add_foreign_key :active_storage_attachments, :active_storage_blobs, column: :blob_id
    end

  end

end
