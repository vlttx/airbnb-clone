class ReviewsController < ApplicationController

	def create
		@review = current_user.reviews.create(review_params)
		redirect_to @review.room
	end

	def destroy
		@review = Review.find(params[:id])
		room = @review.room
		# we need to get a room in order to destroy the review
		@review.destroy

		redirect_to room
	end

	private
		def review_params
			params.require(:review).permit(:comment, :star, :room_id)
			# no need to add user_id as we will use current_user to create review
		end

end
