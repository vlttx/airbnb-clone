class UsersController < ApplicationController
	def show
		if params[:id]
		@user = User.find(params[:id])
	end
end
end