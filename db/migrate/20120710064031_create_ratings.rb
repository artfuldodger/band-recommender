class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :user
      t.references :band
      t.integer :score

      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :band_id
  end
end
