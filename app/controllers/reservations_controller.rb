class ReservationsController < ApplicationController
	before_action :authenticate_user!
	#so that only logged in user can make a reservation

	def preload
		room = Room.find(params[:room_id])
		today = Date.today
		reservations = room.reservations.where("start_date >= ? OR end_date >= ?", today, today)
		# getting only relevant reservations as we dont care abour the past
		render json: reservations
	end

	def preview
		start_date = Date.parse(params[:start_date])
		# gotta parse cause we are converting from string to date
		end_date = Date.parse(params[:end_date])

		output = {
			conflict: is_conflict(start_date, end_date)
			# will be true or false based on the private method
		}

		render json: output
	end

	def create
		@reservation = current_user.reservations.create(reservation_params)

		redirect_to @reservation.room, notice: "Your reservation has been created!"
	end

	private

	def is_conflict(start_date, end_date)
		room = Room.find(params[:room_id])
		check = room.reservations.where("? < start_date AND end_date < ?", start_date, end_date)
		check.size > 0 ? true : false
		# we are checking if we can find any room reservations between the given dates
	end

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :price, :total, :room_id)
		# we don't need current user id because when we create it we create it under a user
	end

end