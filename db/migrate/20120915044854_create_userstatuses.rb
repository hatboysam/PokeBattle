class CreateUserstatuses < ActiveRecord::Migration
  def up
  	create_table :userstatuses do |t|
  		t.integer :user_id
  		t.integer :argument_id
  		t.integer :health

  		t.timestamps
  	end
  end

  def down
  	drop_table :userstatuses
  end
end
