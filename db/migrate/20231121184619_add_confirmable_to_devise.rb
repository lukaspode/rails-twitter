# frozen_string_literal: true

class AddConfirmableToDevise < ActiveRecord::Migration[7.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :confirmation_token, index: {unique: true}
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
    end
  end
end
