class AddPictureToUsers < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.has_attached_file :picture
    end
  end

  def down
    drop_attached_file :users, :picture
  end
end
