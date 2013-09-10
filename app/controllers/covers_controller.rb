class ApplicationController < ActionController::Base
  include ::SslRequirement
end

class CoversController < ApplicationController
  #ssl_exceptions :index, :show
  #ssl_allowed :index, :show
  http_basic_authenticate_with :name => ENV['muser'], :password => ENV['mpwd']
  # GET /covers
  # GET /covers.json
  def index
    @covers = Cover.all(:order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @covers }
    end
  end

  # GET /covers/1
  # GET /covers/1.json
  def show
    @cover = Cover.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cover }
    end
  end

  # GET /covers/new
  # GET /covers/new.json
  def new
    @cover = Cover.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cover }
    end
  end

  # GET /covers/1/edit
  def edit
    @cover = Cover.find(params[:id])
  end

  # POST /covers
  # cover /covers.json
  def create
    @cover = Cover.new(params[:cover])

    respond_to do |format|
      if @cover.save
        format.html { redirect_to @cover, notice: 'cover was successfully created.' }
        format.json { render json: @cover, status: :created, location: @cover }
      else
        format.html { render action: "new" }
        format.json { render json: @cover.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /covers/1
  # PUT /covers/1.json
  def update
    @cover = Cover.find(params[:id])

    respond_to do |format|
      if @cover.update_attributes(params[:cover])
        format.html { redirect_to @cover, notice: 'cover was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cover.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /covers/1
  # DELETE /covers/1.json
  def destroy
    @cover = Cover.find(params[:id])
    @cover.destroy

    respond_to do |format|
      format.html { redirect_to covers_url }
      format.json { head :no_content }
    end
  end
end
