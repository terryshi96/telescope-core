class CreateReceiverMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :receiver_maps do |t|

      t.timestamps
    end
  end
end
