# frozen_string_literal: true

class AddNewFieldsToUser < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.text :bio
      t.string :website
    end
  end
end
