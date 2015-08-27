class CreateCarSelections < ActiveRecord::Migration
  def change
    create_table :car_selections do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :maker

      t.timestamps null: false
    end
  end
end
