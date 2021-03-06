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

ActiveRecord::Schema.define(version: 20191011173110) do

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "leagues", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "playlist_id"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.integer  "number_of_participants", default: 2
    t.integer  "number_of_weeks",        default: 2
    t.integer  "number_of_matches",      default: 2
    t.string   "slug"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["game_id"], name: "index_leagues_on_game_id"
    t.index ["playlist_id"], name: "index_leagues_on_playlist_id"
    t.index ["user_id"], name: "index_leagues_on_user_id"
  end

  create_table "match_outcomes", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "match_id"
    t.integer  "league_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["league_id", "match_id"], name: "index_match_outcomes_on_league_id_and_match_id", unique: true
    t.index ["league_id"], name: "index_match_outcomes_on_league_id"
    t.index ["match_id"], name: "index_match_outcomes_on_match_id"
    t.index ["participant_id", "match_id"], name: "index_match_outcomes_on_participant_id_and_match_id", unique: true
    t.index ["participant_id"], name: "index_match_outcomes_on_participant_id"
  end

  create_table "match_proofs", force: :cascade do |t|
    t.integer  "match_id"
    t.integer  "match_vote_id"
    t.text     "image_data"
    t.text     "description"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["match_id"], name: "index_match_proofs_on_match_id"
    t.index ["match_vote_id"], name: "index_match_proofs_on_match_vote_id"
  end

  create_table "match_relationships", force: :cascade do |t|
    t.integer  "participant_id"
    t.integer  "match_id"
    t.integer  "league_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["league_id"], name: "index_match_relationships_on_league_id"
    t.index ["match_id"], name: "index_match_relationships_on_match_id"
    t.index ["participant_id", "match_id"], name: "index_match_relationships_on_participant_id_and_match_id", unique: true
    t.index ["participant_id"], name: "index_match_relationships_on_participant_id"
  end

  create_table "match_votes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "participant_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["match_id"], name: "index_match_votes_on_match_id"
    t.index ["participant_id"], name: "index_match_votes_on_participant_id"
    t.index ["user_id", "match_id"], name: "index_match_votes_on_user_id_and_match_id", unique: true
    t.index ["user_id"], name: "index_match_votes_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "week_id"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["week_id"], name: "index_matches_on_week_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "league_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_participants_on_league_id"
    t.index ["user_id", "league_id"], name: "index_participants_on_user_id_and_league_id", unique: true
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["game_id"], name: "index_playlists_on_game_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "display_name"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "image_data"
    t.string   "age",          default: ""
    t.string   "city",         default: ""
    t.string   "state",        default: ""
    t.string   "country",      default: ""
    t.string   "website",      default: ""
    t.text     "biography",    default: ""
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "username",               default: "",    null: false
    t.string   "slug",                   default: "",    null: false
    t.boolean  "banned",                 default: false
    t.boolean  "verified",               default: false
    t.boolean  "follow_email",           default: true
    t.boolean  "plus_email",             default: true
    t.boolean  "comment_email",          default: true
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "weeks", force: :cascade do |t|
    t.integer  "league_id"
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["league_id"], name: "index_weeks_on_league_id"
  end

end
