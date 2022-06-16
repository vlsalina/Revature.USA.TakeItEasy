function sendLoginAction() {
  try {
    webkitURL.messageHandlers.loginA.postMessage(
      document.getElementById("email").value +
        " " +
        document.getElementById("password")
    );
  } catch (err) {
    console.log("The native context does not exist yet");
  }
}

function mobileHeader(msg) {
  document.querySelector("h1").innerHTML = msg;
}
