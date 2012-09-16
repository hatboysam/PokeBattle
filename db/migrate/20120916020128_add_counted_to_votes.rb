class AddCountedToVotes < ActiveRecord::Migration
  def change
  	add_column :votes, :counted, :boolean, :default => false
  end
end
