class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.text :content
      t.string :password_value
      t.integer :account_id
    end
  end
end
