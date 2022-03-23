# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_23_140915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: 6, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bank_transaction_lists", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bank_transactions", force: :cascade do |t|
    t.date "posted_at"
    t.integer "amount"
    t.string "description"
    t.string "md5"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "total_cents", default: 0, null: false
    t.bigint "bank_transaction_list_id"
    t.text "analyzed_tokens", default: [], array: true
    t.datetime "analyzed_at", precision: 6
    t.index ["bank_transaction_list_id"], name: "index_bank_transactions_on_bank_transaction_list_id"
  end

  create_table "similarity_matches", force: :cascade do |t|
    t.bigint "source_id", null: false
    t.bigint "destination_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "score"
    t.index ["destination_id"], name: "index_similarity_matches_on_destination_id"
    t.index ["source_id"], name: "index_similarity_matches_on_source_id"
  end

  create_table "tag_relations", force: :cascade do |t|
    t.bigint "tag_id", null: false
    t.string "taggable_type", null: false
    t.bigint "taggable_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tag_id"], name: "index_tag_relations_on_tag_id"
    t.index ["taggable_type", "taggable_id", "tag_id"], name: "index_tag_relations_on_taggable_type_and_taggable_id_and_tag_id", unique: true
    t.index ["taggable_type", "taggable_id"], name: "index_tag_relations_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["value"], name: "index_tags_on_value", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bank_transactions", "bank_transaction_lists"
  add_foreign_key "similarity_matches", "bank_transactions", column: "destination_id"
  add_foreign_key "similarity_matches", "bank_transactions", column: "source_id"
  add_foreign_key "tag_relations", "tags"
end
