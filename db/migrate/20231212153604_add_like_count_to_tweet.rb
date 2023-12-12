# frozen_string_literal: true

class AddLikeCountToTweet < ActiveRecord::Migration[7.1]
  def up
    change_table :tweets, bulk: true do |t|
      t.integer :likes_count, default: 0, null: false
    end

    execute <<~SQL.squish
      UPDATE tweets t
      SET likes_count = (SELECT COUNT(*)
        FROM likes l
        WHERE t.id = l.tweet_id)
    SQL
  end

  def down
    change_table :tweets, bulk: true do |t|
      t.remove :likes_count
    end
  end
end
