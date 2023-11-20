# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def up
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :birth, :date
  end

  execute <<~SQL.squish
    UPDATE users
    SET name = email AND username = email AND birth = '01-01-2000'
  SQL

  change_column_null :users, :name, :username, :birth, false

  def down
    remove_column :users, :name
    remove_column :users, :username
    remove_column :users, :birth
  end
end
