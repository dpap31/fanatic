class CommentsController < ApplicationController

  before_action :find_user
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comment_params)
      @comment.user_id = current_user.id
	  @comment.save
      redirect_to post_path(@post)
    end
    def destroy
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        @comment.destroy
        redirect_to post_path(@post)
      end
  end
private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :commenter, :user, :user_id, :id)   
    end
     
     def find_user
        if params[:user_id]
          @user = User.find_by_id(params[:user_id, :user_name])
      end
    end

