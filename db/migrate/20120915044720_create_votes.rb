class CreateVotes < ActiveRecord::Migration
  def up
  	create_table :votes do |t|
  		t.string  :from
  		t.integer :post_id

  		t.timestamps
  	end
  end

  def down
  	drop_table :votes
  end
end
