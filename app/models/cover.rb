class Cover < ActiveRecord::Base
  attr_accessible :title, :photo
  
  has_attached_file :photo, :styles => { 
	:large => "1544x1024",
	:medium => "300x300", 
	:thumb => "100x100",
	},
	:path => "cover/:attachment/:style/:id.:extension"
	
  validates :title, :presence => true
end