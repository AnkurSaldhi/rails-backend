require 'byebug'
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! ,only: [:index]
  respond_to :json

  # GET /users
  # GET /users.json
  def index
    #it returns all te users
    @users = User.all
    render :json => @users

  end

  # GET /users/1
  # GET /users/1.json
  #before show, set_user function is called
  def show
    render :json => @user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end


  def check_user
    if current_user
      @user = User.find(current_user)
      render json: {response: "success", user_data: @user}, status: :ok
    else
      render :json => {response:"failure"}
    end
  end


  def show_user_posts
    @microposts = Micropost.where(:user_id => current_user.id)
    @comments = []
    #byebug
    @microposts.each { |micropost| @comments.push(micropost.comments)}
    render :json => { :microposts => @microposts, :comments => @comments }
    #render :json => @comments
  end

  # POST /users
  # POST /users.json
  def create
    byebug

    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def signin
    @user = User.find_by(email: params[:email])
    if !@user.nil? && @user.valid_password?(params[:password])
      sign_in(:user, @user)
      #debugger
      render json: {response: "success", user_data: @user}, status: :ok
    else
      render json: {response: "failure"}, status: :ok
    end
  end


  def signout
    #byebug
    @user = User.find(current_user.id)
    if @user
      sign_out(@user)
      render :json => {response: "signout_success"}
    else
      render :json => {response: "signout_failure"}
    end
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email)
    end
end
