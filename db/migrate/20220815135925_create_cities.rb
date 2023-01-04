class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.text :description
      t.string :flag_icon
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
