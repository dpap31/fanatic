class Add < ActiveRecord::Migration
  def change
    rename_column :posts, :post_id, :user_id
  end
end
