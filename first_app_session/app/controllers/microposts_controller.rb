require 'byebug'
class MicropostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  #respond_to :json
  # GET /microposts
  # GET /microposts.json
  def index
    #debugger
    @microposts = Micropost.where(:user_id => params[:user_id])
    render :json => @microposts
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    #byebug
    @comments = Micropost.all.find(params[:id]).comments.paginate(:page => params[:page])

    #@micropost is defined by set_params method which is before action method
    render :json => @micropost
  end


  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end



  def showposts_byuser_id
    @microposts = Micropost.where(:user_id => params[:id])
    render :json => @microposts
  end
  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts
  # POST /microposts.json
  def create

    @micropost = Micropost.new(:content => params[:micropost][:content], :user_id => current_user.id)

    #respond_to do |format|
      if @micropost.save
        #format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
        #format.json { render :show, status: :created, location: @micropost }
        render :json => {response: "success"}
      else
        #format.html { render :new }
        #format.json { render json: @micropost.errors, status: :unprocessable_entity }
        render :json => {response: "failure"}
      end
    #end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if @micropost.update(micropost_params)
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @micropost.destroy
    #respond_to do |format|
     # format.html { redirect_to microposts_url, notice: 'Micropost was successfully destroyed.' }
      #format.json { head :no_content }
    #end
    render :json => { :status => "post deleted"}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:content, :user_id)
    end
end
