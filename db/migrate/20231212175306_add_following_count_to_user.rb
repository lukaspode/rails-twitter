class AddFollowingCountToUser < ActiveRecord::Migration[7.1]
  def up
    change_table :users, bulk: true do |t|
      t.integer :following_count, default: 0, null: false
    end

    execute <<~SQL.squish
      UPDATE users u
      SET following_count = (SELECT COUNT(*)
        FROM follows f
        WHERE u.id = f.follower_id)
    SQL
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :following_count
    end
  end
end
