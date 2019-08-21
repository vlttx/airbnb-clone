class ApplicationController < ActionController::Base
	# before_action :authenticate_user!
	protect_from_forgery with: :exception
	before_action :configure_permitted_parameters, if: :devise_controller?
	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname, :avatar])
		devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :phone_number, :description, :avatar])
	end

	def after_sign_in_path_for(resource)
    	request.env['omniauth.origin'] || root_path
	end
	
end
