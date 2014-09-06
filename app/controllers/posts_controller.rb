class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    #used to randomize team image display
    @all_teams = Team.all
    #if a params tag is passed filter results based on tag else dispay all by hottness
    if params[:tag]
      @posts = hottness(@posts.tagged_with(params[:tag])).paginate(page: params[:page], :per_page => 12)
      @current_team = @all_teams.where(:name => params[:tag].capitalize).first
    else
      @tags_all = ActsAsTaggableOn::Tag.all
      @posts = hottness(Post.all).paginate(page: params[:page], :per_page => 12)
    end 
  end

  def sort_created
    #used to randomize team image display
    @all_teams = Team.all
    #if a params tag is passed filter results based on tag else dispay all by date created
    if params[:tag]
      @posts = Post.order('created_at DESC').tagged_with(params[:tag]).paginate(page: params[:page], :per_page => 12)
    else
      @tags_all = ActsAsTaggableOn::Tag.all
      @posts = Post.order('created_at DESC').paginate(page: params[:page], :per_page => 12)
    end 
  end

  def list
    #Display all posts created by user
    @posts = @posts.where(:user_id => current_user.id).order("created_at DESC").paginate(page: params[:page], :per_page => 12)
    #used to randomize team image display based on users preferences
    @teams = current_user.teams
  end
  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts = Post.find(params[:id])
    @posts_user_id = Post.find(params[:id]).user_id
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.user = current_user

    respond_to do |format|
      if @post.save!
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
        #Create new post activity for feed
        @post.create_activity :create, owner: current_user 
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
      #Create update post activity for feed
      @post.create_activity :update, owner: current_user 
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  #Cheers Count
  def vote
    value = params[:type] == "up" ? 1 : -1
    @post = Post.friendly.find(params[:id])
    @post.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting"
  end

  #Format tag results in JSON to be used by select2 drop down search
  def tags 
    @tags = ActsAsTaggableOn::Tag.where("tags.name LIKE ?", "%#{params[:q]}%") 
    respond_to do |format|
      format.json { render :json => @tags.collect{|t| {:id => t.name, :name => t.name }}}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :visible, :url, :tag_list, :user_id, :id, :user_name, :name, :image, :remote_image_url)
    end
    
    def find_user
      if params[:user_id]
        @user = User.find_by_id(params[:user_id, :user_name])
      end
    end
  end
