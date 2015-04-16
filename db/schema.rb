
ActiveRecord::Schema.define(version: 20150416204308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "criteria", force: :cascade do |t|
    t.string   "description", null: false
    t.string   "kind",        null: false
    t.string   "api_url",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "favorite_properties", force: :cascade do |t|
    t.string   "address",    null: false
    t.integer  "user_id"
    t.integer  "rating",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.integer  "criterium_id", null: false
    t.integer  "score",        null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "first_name",      null: false
    t.string   "last_name",       null: false
    t.string   "gender"
    t.string   "age"
    t.string   "avatar"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
