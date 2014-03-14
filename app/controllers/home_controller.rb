class HomeController < ApplicationController
  def index
    @ids = Cover.ids
	@id = @ids.sample
    @cover = Cover.find(@id)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cover }
    end	
  end
end
