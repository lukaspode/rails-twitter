# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def up
    change_table :users, bulk: true do |t|
      t.string :name
      t.string :username
      t.date :birth
      t.index :username, unique: true
    end

    execute <<~SQL.squish
      UPDATE users
      SET name = email, username = email,  birth = '01-01-2000'
    SQL

    change_column_null :users, :name, false
    change_column_null :users, :birth, false
    change_column_null :users, :username, false
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :name
      t.remove :username
      t.remove :birth
    end
  end
end
