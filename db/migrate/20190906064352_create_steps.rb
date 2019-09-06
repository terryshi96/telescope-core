class CreateSteps < ActiveRecord::Migration[5.2]
  def change
    create_table :steps do |t|
      t.integer :alarm_record_id, index: true 
      t.integer :step_no
      t.text    :mark
      t.integer :user_id, index: true
      t.string  :step_name, default: 'new'
      t.datetime :delete_at
      t.timestamps
    end
  end
end
