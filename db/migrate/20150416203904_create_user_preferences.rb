class CreateUserPreferences < ActiveRecord::Migration
  def change
    create_table :user_preferences do |t|
      t.references :user, null: false
      t.references :criterium, null: false
      t.integer :score, null: false

      t.timestamps null: false
    end
  end
end
