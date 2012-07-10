class AddPictureToBands < ActiveRecord::Migration
  def up
    change_table :bands do |t|
      t.has_attached_file :picture
    end
  end

  def down
    drop_attached_file :bands, :picture
  end
end
