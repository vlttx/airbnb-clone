class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]
  def index
    @rooms = current_user.room
  end

  def show

  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save
      redirect_to @room, notice: "Saved"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @room.update(room_params)
      redirect_to @room, notice: "Updated"
    else
      render :edit
    end
  end


  private

  def set_room
    @room = Room.find(params[:id])
  end 

  def room_params
    params.require(:room).permit(:home_type, :room_type, :accommodates, :bedroom, :bathroom, :listing_name, :summary, :address, :is_tv, :is_kitchen, :is_ac, :is_heating, is_wifi, :price, :active)
  end
end
