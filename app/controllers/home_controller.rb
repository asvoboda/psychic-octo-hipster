class HomeController < ApplicationController
  def index
	@covers = Cover.all(:order => "created_at DESC")
	@cover = @covers.sample
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cover }
    end	
  end
end
