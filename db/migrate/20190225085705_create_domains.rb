class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :url, null: false
      t.integer :remained_days
      t.integer :receiver_group_id, index: true
      t.integer :alert_level
      t.datetime :expire_date
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
