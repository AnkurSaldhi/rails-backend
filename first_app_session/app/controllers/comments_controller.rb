require 'byebug'
class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :get_comments_for_post, only: [:get_comments_for_post]
  # GET /comments
  # GET /comments.json
  def index
    @micropost = Micropost.find(params[:micropost_id])
    @comments = @micropost.comments.all
    render :json => @comments
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new(:micropost_id => params[:micropost_id])
  end



  def get_comments_for_post
    render :json => @comments
  end



  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(:micropost_id => params[:comment][:micropost], :user_id => current_user.id, \
    :body =>  params[:comment][:body])

    #@micropost = Micropost.find(params[:micropost_id])

    #respond_to do |format|
      if @comment.save
        render :json => {:response => "comment saved succcessfully"}
        #format.html { redirect_to @micropost, notice: 'Comment was successfully created.' }
        #format.json { render :show, status: :created, location: @comment }
      else
        #format.html { render :new }
        #format.json { render json: @comment.errors, status: :unprocessable_entity }
      #end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @micropost = Micropost.find(params[:micropost_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @micropost, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @micropost, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :micropost_id)
    end
end
