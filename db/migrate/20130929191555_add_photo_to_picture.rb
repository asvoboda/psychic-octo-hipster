class AddPhotoToPicture < ActiveRecord::Migration
  def self.up
    add_attachment :pictures, :photo
  end

  def self.down
    remove_attachment :pictures, :photo
  end
end
