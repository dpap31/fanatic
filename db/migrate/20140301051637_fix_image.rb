class FixImage < ActiveRecord::Migration
  def change
    rename_column :posts, :postpic, :image

  end
end
