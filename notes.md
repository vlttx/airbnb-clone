

/*
by default the form's id in index.html is new_message cause the form_for path new_message
// the [0] is referring to the text area in the form

// first we'll display all the messages into that div with id chat in index (that's why we
// have @messages there. Then afterwards for each new message we'll append that new message
// into this list. By doing that we won't have to reload all old messages)

// UNCOMMENT AND PUT UP THIS INSTEAD IF YOU WANT TO SEE INSTANT MESSAGING. YOU WOULD ALSO NEED
// TO RUN rackup private_pub.ru -s thin -E production for this to work
// <% publish_to conversation_messages_path(@conversation) do %>

// 		$('#chat').prepend("<%= j render @message %>");
// <% end %>
// 	$('#new_message')[0].reset();
// also add = require private_pub too app.js
*/