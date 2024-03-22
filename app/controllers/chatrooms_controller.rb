class ChatroomsController < ApplicationController

  def index
    @chatrooms = Chatroom.joins(:participants).where(participants: { user: current_user })

  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
  end

end
