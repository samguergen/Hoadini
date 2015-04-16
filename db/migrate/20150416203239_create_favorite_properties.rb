class CreateFavoriteProperties < ActiveRecord::Migration
  def change
    create_table :favorite_properties do |t|
      t.string :address, null: false
      t.integer :rating, null: false

      t.timestamps null: false
    end
  end
end
