class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.boolean :left_breast
      t.boolean :right_breast
      t.integer :bottle_amount
      t.boolean :wet_diaper
      t.boolean :dirty_diaper

      t.timestamps
    end
  end
end
