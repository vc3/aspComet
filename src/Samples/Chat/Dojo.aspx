﻿<%@ Page %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>AspComet chat sample - Dojo</title>
		<!-- Load the Dojo library --> 
		<script src="http://ajax.googleapis.com/ajax/libs/dojo/1.3.1/dojo/dojo.xd.js" type="text/javascript"></script>
		
		<!--- Load the core Cometd library, and the jQuery binding --->
		<script src="lib/cometd.js" type="text/javascript"></script>
		<script src="lib/dojox.cometd.js" type="text/javascript"></script>
		<!-- Load our chat JS file --> 
		<script src="chat.js" type="text/javascript"></script>
		<script type="text/javascript" language="javascript">

		    dojo.addOnLoad(function() {

		        // Ensure we disconnect appropriately
		        dojo.addOnUnload(dojox.cometd, chat.leave);

		        // Get the users name	    
		        var name = window.prompt('Enter your nick name:');
		        var password = window.prompt('Enter your password ("password" will work!):');

		        // Initialise the chat - this will take the Dojo comet object, 
		        // handshake with the server
		        // and then subscribe to the /chat channel
		        chat.init(dojox.cometd, name, password);

		        // Publish any messages the user enters
		        dojo.byId('entry').onsubmit = function() {
		            var msg = dojo.byId('message').value;
		            if (msg) {
		                if (msg.substring(0, 8) == "/whisper") {
		                    dojox.cometd.publish('/service/whisper', { sender: name, message: msg.substring(9) });
		                } else {
		                    dojox.cometd.publish('/chat', { sender: name, message: msg });
		                }
		                dojo.byId('message').value = '';
		                dojo.byId('message').focus();
		            }
		            return false;
		        };

		        // focus the entry box
		        dojo.byId('message').focus();

		    });

	        function handleIncomingMessage(comet) {
			    var message = document.createElement('li');
			    if (!comet.data.sender) message.style.fontStyle = 'italic';
			    message.appendChild(document.createTextNode((comet.data.sender || 'System') + ': ' + comet.data.message));
			    dojo.byId('messages').appendChild(message);
			    dojo.byId('messages').scrollTop = dojo.byId('messages').scrollHeight;
			}

		</script>
		<style type="text/css">
		
		* { margin: 0; padding: 0; }
		body { height: 100%; font: 75% Arial, Helvetica, sans-serif; }
		ul#messages { position: absolute; bottom: 0; top:0; left: 0; right: 0; margin: 0 0 32px 0; padding: 5px; overflow: auto; background: #eee; list-style-type: none; }
		form#entry { height: 22px; position: absolute; bottom: 0; left: 0; width: 100%; padding: 5px 0; background: #ddd; }
		form#entry input { margin: 0 0 0 5px; }
		input#message { width: 30em; }
		
		</style>
	</head>
	<body>
		<ul id="messages">
		</ul>
		
		<form id="entry" action="">
			<input type="text" id="message" />
			<input type="submit" value="&raquo;" />
			&nbsp; try also /whisper &lt;username&gt; &lt;message&gt;
		</form>
	</body>
</html>
