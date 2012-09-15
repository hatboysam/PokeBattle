class CreatePosts < ActiveRecord::Migration
  def up
  	create_table :posts do |t|
  		t.integer :user_id
  		t.string  :content
  		t.integer :argument_id

  		t.timestamps
  	end
  end

  def down
  	drop_table :posts
  end
end
