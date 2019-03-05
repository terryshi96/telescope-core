class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :url, null: false
      t.integer :remained_days
      t.integer :receiver_group_id, index: true
      t.datetime :expire_date
      t.timestamps
    end
  end
end
