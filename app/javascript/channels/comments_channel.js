import consumer from "./consumer"

consumer.subscriptions.create("CommentsChannel", {
  connected() {
    console.log("hello")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("Hi there")
    $("#messages").prepend(data)
  }
});
