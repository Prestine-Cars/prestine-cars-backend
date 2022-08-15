class AddCityRefToCars < ActiveRecord::Migration[7.0]
  def change
    add_reference :cars, :city, null: false, foreign_key: true
  end
end
