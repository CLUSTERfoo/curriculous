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

ActiveRecord::Schema.define(version: 20130823180552) do

  create_table "memo_relationships", force: true do |t|
    t.integer "parent_memo_id", null: false
    t.integer "child_memo_id",  null: false
  end

  add_index "memo_relationships", ["child_memo_id"], name: "index_memo_relationships_on_child_memo_id", using: :btree
  add_index "memo_relationships", ["parent_memo_id"], name: "index_memo_relationships_on_parent_memo_id", using: :btree

  create_table "memos", force: true do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "nsfw",       default: false
  end

  add_index "memos", ["created_at"], name: "index_memos_on_created_at", using: :btree
  add_index "memos", ["user_id", "created_at"], name: "index_memos_on_user_id_and_created_at", using: :btree
  add_index "memos", ["user_id"], name: "index_memos_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username",                                     null: false
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                        default: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
