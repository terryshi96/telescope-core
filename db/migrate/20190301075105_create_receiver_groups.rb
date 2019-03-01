class CreateReceiverGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :receiver_groups do |t|

      t.timestamps
    end
  end
end
