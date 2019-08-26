class ReservationsController < ApplicationController
	before_action :authenticate_user!, except: [:notify]
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

		if @reservation
			
			# send request to paypal -- for that you need to use ngrok or something similar because
			# otherwise PP wont be able to send a message about a completed payment.
			values = {
				business: 'victoriasnotebooks-facilitator@gmail.com',
				cmd: '_xclick',
				upload: 1,
				notify_url: 'http://0ead7859.ngrok.io/notify',
				# notify and your_trips are actions
				amount: @reservation.total,
				item_name: @reservation.room.listing_name,
				item_number: @reservation.id,
				quantity: '1',
				return: 'http://0ead7859.ngrok.io/your_trips'
			}
			redirect_to "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
		else
			redirect_to @reservation.room, alert: "There seems to be an issue with the request."
		end
	end

	protect_from_forgery except: [:notify]
	def notify
		params.permit!
		# permit all pp input params
		status = params[:payment_status]
		# payment status is returned by PP
		reservation = Reservation.find(params[:item_number])

		if status = "Completed"
			reservation.update_attributes status: true
		else
			reservation.destroy
		end

		render nothing: true
	end

	protect_from_forgery except: [:your_trips]
	def your_trips
		@trips = current_user.reservations.where("status = ?", true)
	end

	def your_reservations
		@rooms = current_user.rooms
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