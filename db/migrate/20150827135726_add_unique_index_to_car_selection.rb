class AddUniqueIndexToCarSelection < ActiveRecord::Migration
  def change
    add_index :car_selections, [:user_id, :maker], unique: true
  end
end
