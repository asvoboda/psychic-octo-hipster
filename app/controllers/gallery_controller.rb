class GalleryController < ApplicationController
  def index
	@posts = Post.where("PHOTO_FILE_NAME IS NOT NULL")
	@covers = Cover.all()
	@pictures = Picture.all()
	@photos = (@posts + @covers + @pictures).sort! {|x,y| y.created_at <=> x.created_at}

	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photos }
    end
  end
end
