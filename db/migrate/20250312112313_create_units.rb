class CreateUnits < ActiveRecord::Migration[7.2]
  def change
    create_table :units do |t|
      t.integer :number, null: false
      t.string :floorplan, null: false
      t.string :occupant_name
      t.date :move_in_date
      t.date :move_out_date
      t.timestamps
    end
  end
end
