<%--
  Created by IntelliJ IDEA.
  User: HaouJohan
  Date: 11/28/2016
  Time: 2:05 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Web Socket Chat</title>
</head>
<script
        src="https://code.jquery.com/jquery-3.1.1.slim.min.js"
        integrity="sha256-/SIrNqv8h6QGKDuNoLGA4iret+kyesCkHGzVUUV0shc="
        crossorigin="anonymous"></script>
<script>
  var ws;
  $(document).ready(function(){
    $("#register").click(function() {
      var user = $('#id').val();
      ws = new WebSocket("ws://localhost:8080/chat/"+user);
      $('#onlineUser').append(user + ", ");
      ws.onmessage = function(evt)
      {
        var msg = evt.data;
        $('#chat').append(msg + '\n');
      };
    });


    $("#send").click(function() {
      var txt = $('#message').val()
      ws.send(txt.bold().fontcolor("orange"));
    });
  });
</script>
<body>
<form>
  <input type="text" id="id" name="id" placeholder="Enter your id" /> <br>
  <input type="button" id="register" value="Register" /> <br>
  <textarea id="chat" placeholder="Chat message appears here" rows="10" cols="50" readonly >
...
</textarea><br>
  <input type="text" id="message" name="id" placeholder="Enter your message" /> <br>
  <input type="button" id="send" value="Send" /> <br>
  <p>Online Users:</p>
  <textarea id="onlineUser" rows="10" cols="30" placeholder="Online users">
  </textarea>
</form>
</body>
</html>

