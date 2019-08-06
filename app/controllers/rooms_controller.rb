class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update]
  before_action :authenticate_user!, except: [:show]

  def index
    @rooms = current_user.room
  end

  def show
      @photos = @room.photos
  end

  def new
    @room = current_user.rooms.build
  end

  def create
    @room = current_user.rooms.build(room_params)

    if @room.save

      if params[:images]
        # if we can find images, then we'll look through the list and create photos for the room
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end
      @photos = @room.photos
      # we are going to display a list of photos, that is why it is necessary
      redirect_to edit_room_path@room), notice: "Saved"
    else
      render :new
    end
  end

  def edit
    if current_user.id == @room.user_id
      @photos = @room.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @room.update(room_params)
      if params[:images]
        # if we can find images, then we'll look through the list and create photos for the room
        params[:images].each do |image|
          @room.photos.create(image: image)
        end
      end
      redirect_to edit_room_path@room), notice: "Updated"
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
