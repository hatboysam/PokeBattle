class CreateArguments < ActiveRecord::Migration
  def up
  	create_table :arguments do |t|
  		t.integer :user_id1
  		t.integer :user_id2
  		t.string  :topic
  		t.string  :textcode
  		t.integer :winner_id

  		t.timestamps
  	end
  end

  def down
  	drop_table :arguments
  end
end
