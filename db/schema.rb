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

ActiveRecord::Schema.define(version: 20190305095039) do

  create_table "cocktails", force: :cascade do |t|
    t.string "name"
    t.integer "taste_sweet_sugar"
    t.integer "taste_sweet_fruit"
    t.integer "taste_fresh"
    t.integer "taste_bitters_fruit"
    t.integer "taste_bitters_drink"
    t.integer "alcohol"
    t.integer "amount"
    t.string "etc"
    t.string "mouthfeel"
    t.string "base"
    t.boolean "soda"
    t.string "about"
    t.string "ment"
    t.string "link"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "counts", force: :cascade do |t|
    t.string "name"
    t.integer "taste_sweet_sugar"
    t.integer "taste_sweet_fruit"
    t.integer "taste_fresh"
    t.integer "taste_bitters_fruit"
    t.integer "taste_bitters_drink"
    t.integer "alcohol"
    t.integer "amount"
    t.string "avoid"
    t.string "challenge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
