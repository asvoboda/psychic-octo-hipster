class Picture < ActiveRecord::Base
  attr_accessible :title, :photo
  
  has_attached_file :photo, :styles => { 
	:large => "1544x1024",
	:medium => "300x300", 
	:thumb => "100x100",
	},
	:path => "picture/:attachment/:style/:id.:extension"

  validates :title, :presence => true
end