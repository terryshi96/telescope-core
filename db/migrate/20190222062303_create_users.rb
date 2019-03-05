class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, index: true, null: false
      t.string :name, index: true, null: false
      t.datetime :activated
      t.boolean :admin, default: false
      t.string :authentication_token
      t.string :password_digest
      t.timestamps
    end
  end
end
