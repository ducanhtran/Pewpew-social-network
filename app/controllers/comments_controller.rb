class CommentsController < ApplicationController

    def index
      @comment = Comment.all
    end
    
    def new
      @comment = Comment.new
    end
    
    def create
      @comment = Comment.new(commentParams)
      @comment.micropost_id = params["micropost_id"]
      @comment.user_id = current_user.id
      if @comment.save
        redirect_to root_path
      else
        render "new"
      end
    end
    
    def show
      @comment = Comment.find(params[:id])
    end
    
    private
    
      def commentParams
        params.require(:comment).permit(:body, :micropost_id)
      end

end
