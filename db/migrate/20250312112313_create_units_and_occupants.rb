class CreateUnitsAndOccupants < ActiveRecord::Migration[7.2]
  def change
    create_table :units do |t|
      t.integer :number, null: false
      t.string :floorplan, null: false
      t.timestamps
    end

    create_table :occupants do |t|
      t.references :unit
      t.string :name, null: false
      t.date :move_in_date
      t.date :move_out_date
    end
  end
end
