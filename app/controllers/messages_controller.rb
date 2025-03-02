class MessagesController < ApplicationController
  before_action :set_room

  def new
    @message = @room.messages.new
  end

  def create
    @message = @room.messages.build(message_params)

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @room }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_message", partial: "messages/form", locals: { message: @message })
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
