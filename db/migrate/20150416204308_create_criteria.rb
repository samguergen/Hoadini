class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.string :description, null: false
      t.string :type, null: false
      t.string :api_url, null: false

      t.timestamps null: false
    end
  end
end
