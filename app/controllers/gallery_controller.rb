class GalleryController < ApplicationController
  def index
	@posts = Post.where("PHOTO_FILE_NAME IS NOT NULL").order('created_at DESC')
	respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end
end
