class CommentsController < ApplicationController
	  before_action :get_comment, only: [:create, :destroy]
	  
    def create
	 	@comment = @post.comments.new(comment_params.merge(user_id: current_user.id))
		if @comment.save
			NotificationMailer.notification_email(current_user).deliver
			redirect_to post_path(@post)
		else
			render new
		end	
	end

	def destroy
		@comment = @post.comments.find(params[:id])
		@comment.destroy
		redirect_to post_path(@post)
	end

	private
        def comment_params
            params.require(:comment).permit(:content)
        end
end
