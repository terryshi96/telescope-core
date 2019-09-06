class CreateAlarmRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :alarm_records do |t|
      t.string :subject, index: true, null: false
      t.text :content, null: false
      t.string :status, default: 'new'
      t.datetime :delete_at
      t.datetime :last_receive
      t.timestamps
    end
  end
end
