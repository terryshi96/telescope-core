class CreateReceiverMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :receiver_maps do |t|
      t.belongs_to :receiver, index: true
      t.belongs_to :receiver_group, index: true
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
