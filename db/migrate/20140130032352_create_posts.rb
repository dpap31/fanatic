class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
    	t.integer "user_id"
    	t.string "url"
    	t.string "title"
    	t.text "content"
    	t.boolean "visible", :default => false
      t.timestamps
    end
  end
end