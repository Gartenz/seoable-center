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

ActiveRecord::Schema.define(version: 2019_07_11_115439) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pages", force: :cascade do |t|
    t.bigint "site_id"
    t.string "url"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastmod"
    t.index ["site_id"], name: "index_pages_on_site_id"
    t.index ["url"], name: "index_pages_on_url", unique: true
  end

  create_table "robots", force: :cascade do |t|
    t.bigint "site_id"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_robots_on_site_id"
  end

  create_table "sitemaps", force: :cascade do |t|
    t.bigint "site_id"
    t.text "body"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lastmod"
    t.index ["site_id"], name: "index_sitemaps_on_site_id"
    t.index ["url"], name: "index_sitemaps_on_url", unique: true
  end

  create_table "sites", force: :cascade do |t|
    t.string "url"
    t.boolean "https"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "statistics", force: :cascade do |t|
    t.bigint "page_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_statistics_on_page_id"
  end

  add_foreign_key "pages", "sites"
  add_foreign_key "sitemaps", "sites"
  add_foreign_key "statistics", "pages"
end
