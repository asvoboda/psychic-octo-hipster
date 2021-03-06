class Post < ActiveRecord::Base
  attr_accessible :content, :name, :title, :photo
  
  has_attached_file :photo, :styles => { 
	:large => "600x600>",
	:medium => "300x300", 
	:thumb => "100x100>",
	},
	:storage => :s3,
	:path => "post/:attachment/:style/:id.:extension",
	:bucket => 'media.andrewsvoboda.me',
	:s3_credentials => {
		:secret_access_key => ENV['secret_access_key'],
		:access_key_id => ENV['access_key_id']
	}

  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 3 }  
  has_many :comments
end
