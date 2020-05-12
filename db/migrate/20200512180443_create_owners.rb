class CreateOwners < ActiveRecord::Migration[5.2]
  create_table :owners do |t|
    t.string :name
    t.string :password_digest
  end
end
