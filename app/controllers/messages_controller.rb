class MessagesController < ApplicationController
  def index
    @room=Room.find(params[:room_id])
    @message=Message.new
    @messages=@room.messages.includes(:user)
  end
  def create
    @room=Room.find(params[:room_id])
    @message=@room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room.id)
    else
      @messages=@room.messages.includes(:user)
      render :index,status: :unprocessable_entity
    end
  end
  private
  def message_params
    params.require(:message).permit(:content,:image).merge(user_id: current_user.id)
  end
end
