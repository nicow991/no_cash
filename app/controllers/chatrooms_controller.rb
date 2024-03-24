class ChatroomsController < ApplicationController
  def create
    @chatroom = Chatroom.between(current_user.id, chatroom_params[:user_id])
    if @chatroom.nil?
      @chatroom = Chatroom.create
      user = User.find chatroom_params[:user_id]
      @chatroom.users = [current_user, user]
    end
    redirect_to @chatroom
  end
  def index
    @chatrooms = Chatroom.joins(:participants).where(participants: { user: current_user })
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:user_id)
  end
end
