class IrsController < ApplicationController
  def index
	respond_to do |format|
	  # Feb 8, 2015 TODO: is this correct?
	  @irs = (Date.new(2015, 02, 8) - Date.today).to_i
      format.html # index.html.erb
      format.json { render json: @irs }
	end
  end
end
