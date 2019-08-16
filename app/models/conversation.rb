class Conversation < ApplicationRecord

	belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
	belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'

	has_many :messages, dependent: :destroy
	validates_uniqueness_of :sender_id, scope: :recipient_id
	scope :involving, -> (user) do
		where("conversations.sender_id = ? OR conversations.recipient_id = ?", user.id, user.id)

		# the first scope is only for currently logged in user and the second is to check whether a convo already exists between
		# any two users before we create a convo, no matter who is the sender and who is the recipient.
	scope :between, -> (sender_id, recipient_id) do 
		where("(conversation.sender_id = ? AND conversations.recipient_id = ?) OR (conversation.sender_id = ? AND conversations.recipient_id = ?)",
			sender_id, recipient_id, recipient_id, sender_id)
		
	end
end
