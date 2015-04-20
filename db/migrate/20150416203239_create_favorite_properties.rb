class CreateFavoriteProperties < ActiveRecord::Migration
  def change
    create_table :favorite_properties do |t|
      t.string :z_id
      t.string :address, null: false
      t.integer :rating, null: false, default: 0
      t.integer :price
      t.string :picture
      t.string :title
      t.string :description
      t.references :user


      t.timestamps null: false
    end
  end
end
