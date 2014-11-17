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

ActiveRecord::Schema.define(version: 20141113195550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "comunas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comunas", ["name"], :name => "index_comunas_on_name", :unique => true

  create_table "direcciones", force: true do |t|
    t.string   "direccion"
    t.integer  "numero"
    t.string   "bloque"
    t.string   "dpto"
    t.string   "villa"
    t.integer  "hogar_id"
    t.integer  "comuna_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.spatial  "loc",        limit: {:srid=>3785, :type=>"point"}
  end

  add_index "direcciones", ["comuna_id"], :name => "index_direcciones_on_comuna_id"
  add_index "direcciones", ["direccion", "numero", "bloque", "dpto", "comuna_id"], :name => "noLaMismaDireccion", :unique => true
  add_index "direcciones", ["hogar_id"], :name => "index_direcciones_on_hogar_id"
  add_index "direcciones", ["loc"], :name => "index_direcciones_on_loc", :spatial => true

  create_table "hogares", force: true do |t|
    t.integer  "user_admin_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "hogares", ["user_admin_id"], :name => "index_hogares_on_user_admin_id", :unique => true

  create_table "megustas", force: true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.boolean  "megusta",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "megustas", ["post_id", "user_id"], :name => "index_megustas_on_post_id_and_user_id", :unique => true
  add_index "megustas", ["post_id"], :name => "index_megustas_on_post_id"
  add_index "megustas", ["user_id"], :name => "index_megustas_on_user_id"

  create_table "posts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "tag_id"
  end

  add_index "posts", ["tag_id"], :name => "index_posts_on_tag_id"
  add_index "posts", ["user_id", "created_at"], :name => "index_posts_on_user_id_and_created_at"
  add_index "posts", ["user_id"], :name => "index_posts_on_user_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "slug"
    t.boolean  "enform",     default: false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true
  add_index "tags", ["slug"], :name => "index_tags_on_slug", :unique => true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "hogar_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["hogar_id"], :name => "index_users_on_hogar_id"

end
