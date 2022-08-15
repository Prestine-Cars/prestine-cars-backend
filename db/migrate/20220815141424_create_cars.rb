class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :model
      t.string :photo
      t.text :description
      t.decimal :cost
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
