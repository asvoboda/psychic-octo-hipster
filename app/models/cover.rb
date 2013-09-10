class Cover < ActiveRecord::Base
  attr_accessible :title, :photo
  
  has_attached_file :photo, :styles => { 
	:large => "1544x1024",
	:medium => "300x300", 
	:thumb => "100x100",
	},
	:storage => :s3,
	:path => "cover/:attachment/:style/:id.:extension",
	:bucket => 'media.andrewsvoboda.me',
	:s3_credentials => {
		:secret_access_key => ENV['secret_access_key'],
		:access_key_id => ENV['access_key_id']
	}
	
  validates :title, :presence => true
end