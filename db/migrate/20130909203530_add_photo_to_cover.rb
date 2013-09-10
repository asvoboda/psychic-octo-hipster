class AddPhotoToCover < ActiveRecord::Migration
  def self.up
    add_attachment :covers, :photo
  end

  def self.down
    remove_attachment :covers, :photo
  end
end
