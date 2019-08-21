module ApplicationHelper

	def avatar_url(id)
		user = User.all.find_by(id: id)
		if user && user.image?
			user.image
		else
		 "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
		# "https://store.playstation.com/store/api/chihiro/00_09_000/container/US/en/99/UP2538-CUSA05620_00-AV00000000000101//image?_version=00_09_000&platform=chihiro&w=720&h=720&bg_color=000000&opacity=100"
	end

		# gravatar_id = Digest::MD5::hexdigest(user.email).downcase
		# "https://www.gravatar.com/avatar/#{gravatar_id}.jpg?d=identical&s=150"
	end
end


# you take users email and encode email with MD5 standard and downcase its value
# user has to have a gravatar though for us to import it
# for real method you need to pass a user