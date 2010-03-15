# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090714045340) do

  create_table "OLD_schema_migrations", :primary_key => "version", :force => true do |t|
  end

  add_index "OLD_schema_migrations", ["version"], :name => "unique_schema_migrations", :unique => true

  create_table "activities", :force => true do |t|
    t.string   "description"
    t.string   "action_type"
    t.integer  "action_id"
    t.datetime "created_at"
    t.integer  "user_id"
  end

  add_index "activities", ["created_at"], :name => "index_activities_on_created_at"

  create_table "associations", :force => true do |t|
    t.integer  "media_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.string   "commentable_type"
    t.integer  "commentable_id"
    t.integer  "commentator_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "commentator_type"
    t.boolean  "show"
    t.boolean  "archived",         :default => false
    t.boolean  "new",              :default => true
    t.string   "title"
  end

  create_table "issues", :force => true do |t|
    t.string   "title"
    t.text     "intro"
    t.integer  "volume_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number"
    t.boolean  "active",     :default => false
    t.boolean  "published",  :default => false
    t.integer  "feature_id"
  end

  create_table "medias", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "embed"
    t.text     "content"
    t.text     "excerpt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "status",        :default => "Pending Review"
    t.string   "file"
    t.string   "media_type"
    t.string   "media_class"
    t.boolean  "in_archive"
    t.integer  "issue_id"
    t.integer  "newsletter_id"
    t.datetime "published_at"
    t.string   "uri"
    t.integer  "visits_count"
  end

  add_index "medias", ["visits_count"], :name => "index_visits_count_on_medias"

  create_table "medias_posts", :id => false, :force => true do |t|
    t.integer "media_id"
    t.integer "post_id"
  end

  create_table "medias_tags", :id => false, :force => true do |t|
    t.integer "media_id"
    t.integer "tag_id"
  end

  create_table "newsletters", :force => true do |t|
    t.integer  "issue_id"
    t.string   "title"
    t.text     "intro"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "feature_id"
    t.text     "html",       :limit => 2147483647
    t.text     "text",       :limit => 2147483647
  end

  create_table "pages", :force => true do |t|
    t.string  "title"
    t.string  "uri"
    t.text    "content"
    t.date    "created_at"
    t.date    "updated_at"
    t.string  "status",       :default => "Pending Review"
    t.integer "page_id"
    t.integer "page_order"
    t.integer "user_id",                                    :null => false
    t.text    "quote"
    t.string  "quote_author"
    t.integer "media_id"
    t.string  "quote_source"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",         :default => "pending"
    t.integer  "user_id"
    t.string   "old_section"
    t.text     "excerpt"
    t.boolean  "in_archive"
    t.integer  "issue_id"
    t.integer  "newsletter_id"
    t.datetime "published_at"
    t.text     "source"
    t.string   "uri"
    t.boolean  "published",      :default => false
    t.integer  "visits_count"
    t.integer  "comments_count"
  end

  add_index "posts", ["comments_count"], :name => "index_comments_count_on_posts"
  add_index "posts", ["visits_count"], :name => "index_visits_count_on_posts"

  create_table "posts_sections", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "section_id"
  end

  create_table "posts_tags", :id => false, :force => true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  create_table "rights", :force => true do |t|
    t.string "name"
    t.string "controller"
    t.string "actions"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "authorizable_type", :limit => 30
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uri"
  end

  create_table "settings", :force => true do |t|
    t.boolean  "comment_moderation",   :default => true
    t.integer  "comment_expiration"
    t.text     "next_issue_text"
    t.date     "next_issue_date"
    t.text     "comment_instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "next_issue_author"
    t.text     "analytics"
    t.integer  "subscribe_page_id"
    t.integer  "connection_page_id"
    t.integer  "archive_page_id"
    t.boolean  "show_date",            :default => false
    t.text     "sharethis"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.boolean  "read",       :default => false
    t.integer  "user_id"
  end

  create_table "tags", :force => true do |t|
    t.string "name"
    t.text   "description"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "display_name"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "confirmed",                               :default => false
    t.text     "description"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
  end

  create_table "visitors", :force => true do |t|
    t.string   "ip"
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "visits", :force => true do |t|
    t.integer  "visitable_id"
    t.integer  "visitor_id"
    t.string   "visitable_type"
    t.string   "request_url"
    t.string   "referer"
    t.string   "ip_address"
    t.string   "user_agent"
    t.text     "session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["created_at"], :name => "index_visits_on_created_at"
  add_index "visits", ["visitable_id", "visitable_type"], :name => "index_visits_on_visitable_id_and_visitable_type"

  create_table "volumes", :force => true do |t|
    t.string   "title"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",     :default => false
    t.boolean  "published",  :default => false
  end

end
