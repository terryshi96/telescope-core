class CreateReceiverGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :receiver_groups do |t|
      t.string :name, null: false
      t.boolean :active, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
