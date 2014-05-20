class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :role]

  # GET /users
  # GET /users.json
  def index
    @search = User.search do
    fulltext params[:search]
  end
    @users = @search.results
  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  def dashboard
     @user = current_user
     @teams = current_user.teams
     @my_posts = current_user.posts.limit(3)
     @fan = Post.tagged_with('NBA').page(params[:page]).per_page(12)
  end

  # GET /users/new
  def new
    @user = current_user
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

# Used to get all posts created by a specific user
def posts
    @user = User.find_by_id(params[:id])
    @posts = @user.posts.page(params[:page]).per_page(12)
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params[:user].permit(:id, :username, :first_name, :last_name, :email, :name, :image, :search, :role, team_ids: [])
    end
end
