class ReservationsController < ApplicationController
	before_action :authenticate_user!
	#so that only logged in user can make a reservation

	def preload
		room = Room.find(params[:room_id])
		today = Date.today
		reservations = room.reservations.where("start_date >= ? OR end_date >= ?", today, today)
		# getting only relevant reservations as we dont care abour the past
		render json: reservations

	def create
		@reservation = current_user.reservations.create(reservation_params)

		redirect_to @reservation.room, notice: "Your reservation has been created!"
	end

	private

	def reservations_params
		params.require(:reservation).permit(:start_date, :end_date, :price, :total, :room_id)
		# we don't need current user id because when we create it we create it under a user
	end

end