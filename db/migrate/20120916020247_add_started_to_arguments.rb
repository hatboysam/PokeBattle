class AddStartedToArguments < ActiveRecord::Migration
  def change
  	  add_column :arguments, :started, :boolean, :default => false
  end
end
