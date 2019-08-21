

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


google maps with geocoder (did not work due to api restrictions)


<div class="row">
			<div class="col-md-12">
				<div id="map"></div>

				<style>
		      #map {
		        width: 100%;
		        height: 400px;
		      }
		    </style>


		     <script src="https://maps.googleapis.com/maps/api/js"></script>
		    <script>
		      function initialize() {
		        var mapCanvas = document.getElementById('map');
		        // we display map when we see id map, which is why we have a div with an id map above
		        var mapOptions = {
		          center: new google.maps.LatLng(<%= @room.latitude %>, <%= @room.longitude %>),
		          zoom: 14,
		          mapTypeId: google.maps.MapTypeId.ROADMAP
		        }
		        var map = new google.maps.Map(mapCanvas, mapOptions);

		        var marker = new google.maps.Marker({
		        	position: new google.maps.LatLng(<%= @room.latitude %>, <%= @room.longitude %>),
		        	title: "Available" 
		        });

		        marker.setMap(map);
		      }
		      google.maps.event.addDomListener(window, 'load', initialize);
		    </script>

			</div>
		</div>