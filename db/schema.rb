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

ActiveRecord::Schema[7.0].define(version: 2023_02_11_055159) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "group", force: :cascade do |t|
    t.integer "creator_id"
    t.text "group_name"
    t.text "invite_code"
  end

  create_table "group_user", force: :cascade do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  create_table "note", force: :cascade do |t|
    t.integer "user_id"
    t.text "description"
    t.text "created_at"
    t.text "updated_at"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task", force: :cascade do |t|
    t.text "description"
    t.integer "done"
    t.text "create_at"
    t.text "updated_at"
    t.integer "user_id"
  end

  create_table "task_group_user", id: false, force: :cascade do |t|
    t.integer "task_id"
    t.integer "group_user_id"
    t.text "deadline"
  end

  create_table "user", force: :cascade do |t|
    t.text "username", null: false
    t.text "password", null: false
    t.text "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "age"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "group", "user", column: "creator_id", primary_key: "id"
  add_foreign_key "group_user", "group", primary_key: "id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "group_user", "user", primary_key: "id"
  add_foreign_key "note", "user", primary_key: "id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "task", "user", primary_key: "id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "task_group_user", "group_user", primary_key: "id"
  add_foreign_key "task_group_user", "task", primary_key: "id"
end
