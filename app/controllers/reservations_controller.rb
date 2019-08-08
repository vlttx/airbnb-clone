class ReservationsController < ApplicationController
	before_action :authenticate_user!
	#so that only logged in user can make a reservation

	def create
		@reservation = current_user.reservations.create(reservation_params)

		redirect_to @reservation.room
	end

	private

	def reservations_params
		params.require(:reservation).permit(:start_date, :end_date, :price, :total, :room_id)
		# we don't need current user id because when we create it we create it under a user
	end

end