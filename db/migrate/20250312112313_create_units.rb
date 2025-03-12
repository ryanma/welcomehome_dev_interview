class CreateUnits < ActiveRecord::Migration[7.2]
  def change
    create_table :units do |t|
      t.integer :number, null: false
      t.string :floorplan, null: false
      t.string :occupant_name
      t.timestamps
    end
  end
end
