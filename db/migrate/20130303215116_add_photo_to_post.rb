class AddPhotoToPost < ActiveRecord::Migration
  def self.up
    add_attachment :post, :photo
  end

  def self.down
    remove_attachment :post, :photo
  end
end
