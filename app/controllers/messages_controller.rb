class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @message = Message.create!(message_params)
    @message.user_id = current_user.id
    @message.save
  end
end

private
   def message_params
      params.require(:message).permit(:user_id, :content)   
    end