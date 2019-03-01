class CreateReceivers < ActiveRecord::Migration[5.2]
  def change
    create_table :receivers do |t|

      t.timestamps
    end
  end
end
