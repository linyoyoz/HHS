class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.integer :hid
      t.string :name
      t.integer :price
      t.string :other
      t.integer :imform

      t.timestamps
    end
  end
end
