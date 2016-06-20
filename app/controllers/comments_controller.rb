class CommentsController < ApplicationController

  def create
   @pin = Pin.find(params[:pin_id])
   c_params = comment_params
   c_params["user_id"] = current_user.id
   p c_params
   @comment = @pin.comments.create(c_params)
   redirect_to pin_path(@pin)
 end

 private
   def comment_params
     params.require(:comment).permit(:body)
   end

end
