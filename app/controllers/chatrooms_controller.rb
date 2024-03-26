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
    remove_empty_chatrooms
    @chatrooms = Chatroom.joins(:participants).where(participants: { user: current_user })
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
    @chatroom.messages.where.not(user: current_user).each { |message| message.update(read: true) }
  end

  private

  def remove_empty_chatrooms
    current_user.chatrooms.each do |chatroom|
      chatroom.destroy if chatroom.messages.empty?
    end
  end

  def chatroom_params
    params.require(:chatroom).permit(:user_id)
  end
end
