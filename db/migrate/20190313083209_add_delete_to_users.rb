class AddDeleteToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :deleted_at, :datetime, comment: '删除时间'
    add_column :receivers, :deleted_at, :datetime, comment: '删除时间'
    add_column :domains, :deleted_at, :datetime, comment: '删除时间'
    add_column :receiver_groups, :deleted_at, :datetime, comment: '删除时间'
    add_column :receiver_maps, :deleted_at, :datetime, comment: '删除时间'
  end
end
