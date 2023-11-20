# frozen_string_literal: true

class AddFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :username, :string, null: false
    add_column :users, :birth, :date, null: false
  end
end
