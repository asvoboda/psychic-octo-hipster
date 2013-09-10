class CreateCovers < ActiveRecord::Migration
  def change
    create_table :covers do |t|
      t.string :title
      t.timestamps
    end
  end
end