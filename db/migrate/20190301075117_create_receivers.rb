class CreateReceivers < ActiveRecord::Migration[5.2]
  def change
    create_table :receivers do |t|
      t.string :name, null: false
      t.string :phone
      t.string :mail
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
