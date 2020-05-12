class CreatePasswords < ActiveRecord::Migration[5.2]
  def change :passwords do |t|
    t.string :account_type
    t.float :account
    t.integer :value
    t.integer :owner_id
    t.integer :account_id
    end
  end
end
