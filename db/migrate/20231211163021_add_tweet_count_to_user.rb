# frozen_string_literal: true

class AddTweetCountToUser < ActiveRecord::Migration[7.1]
  def up
    change_table :users, bulk: true do |t|
      t.integer :tweets_count, default: 0, null: false
    end

    execute <<~SQL.squish
      UPDATE users u
      SET tweets_count = (SELECT COUNT(*)
        FROM tweets t
        WHERE u.id = t.user_id)
    SQL
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :tweets_count
    end
  end
end
