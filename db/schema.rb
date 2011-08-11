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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110811035046) do

  create_table "actors", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.integer  "feature_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimate_signatures", :force => true do |t|
    t.integer  "user_id"
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "estimates", :force => true do |t|
    t.integer  "developer_signature_id"
    t.integer  "client_signature_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "feature_estimates", :force => true do |t|
    t.integer  "estimate_id"
    t.integer  "feature_id"
    t.integer  "min_hours"
    t.integer  "max_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feature_versions", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "version"
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_feature_id"
    t.integer  "developer_signature_id"
    t.integer  "client_signature_id"
    t.integer  "updated_by_id"
    t.text     "test_report"
    t.integer  "num_tests",              :default => 0
    t.integer  "num_failures",           :default => 0
  end

  add_index "feature_versions", ["feature_id"], :name => "index_feature_versions_on_feature_id"

  create_table "features", :force => true do |t|
    t.integer  "project_id"
    t.string   "title"
    t.text     "description"
    t.integer  "actor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_feature_id"
    t.integer  "version"
    t.integer  "developer_signature_id"
    t.integer  "client_signature_id"
    t.integer  "updated_by_id"
    t.text     "test_report"
    t.integer  "num_tests",              :default => 0
    t.integer  "num_failures",           :default => 0
  end

  create_table "glossary_terms", :force => true do |t|
    t.integer  "project_id"
    t.string   "name"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "project_id"
    t.string   "uuid"
    t.string   "email"
    t.boolean  "admin",      :default => false
    t.boolean  "developer",  :default => false
    t.boolean  "client",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "estimate_id"
    t.string   "description"
    t.integer  "min_hours"
    t.integer  "max_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memberships", :force => true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",      :default => false
    t.boolean  "developer",  :default => false
    t.boolean  "client",     :default => false
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_feature_id_counter", :default => 0
    t.string   "api_key"
    t.boolean  "public",                     :default => false
  end

  create_table "signatures", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "time_zone"
    t.string   "locale"
  end

end
