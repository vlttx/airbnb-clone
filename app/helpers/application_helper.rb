module ApplicationHelper

	def avatar_url

		if current_user.image?
			current_user.image
		else
		"https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50?f=y"
	end

		# gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		# "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
	end
end


# you take users email and encode email with MD5 standard and downcase its value
# user has to have a gravatar though for us to import it
# for real method you need to pass a user