class AddConfirmableToDevise < ActiveRecord::Migration[7.1]

  def up
    change_table :users, bulk: true do |t|
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email
      t.index :confirmation_token, unique: true
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
      t.remove :unconfirmed_email
    end
  end

end
