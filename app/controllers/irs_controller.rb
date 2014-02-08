class IrsController < ApplicationController
  def index
	respond_to do |format|
	  # Feb 7, 2015 TODO: is this correct?
	  @irs = (Date.new(2015, 02, 7) - Date.today).to_i
	  @pct_complete = ((1825.00 - @irs) / 1825.00) * 100
      format.html # index.html.erb
      format.json { render json: @irs }
	end
  end
end
