class CreatePasswords < ActiveRecord::Migration
  def change
    create_table :passwords do |t|
      t.string :content
      t.integer :account_id
    end
  end
end
