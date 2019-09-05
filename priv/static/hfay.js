document.addEventListener('DOMContentLoaded', (event) => {
  const [cookie, uuid] = document.cookie.match("uuid=([^;]*)");
  const [playButton, resultsList] = document.querySelectorAll("#play-button, #results-list");

  let state = "start";
  let socket = new ReconnectingWebSocket(`ws://${location.host}/ws`);

  socket.onmessage = (event) => {
    const [status, duration] = event.data.split(":");
    if (status === "started") { state = "stop"; }
    if (status === "stopped") {
      const li = document.createElement("li");
      li.appendChild(document.createTextNode(`${duration}ms`));
      resultsList.insertBefore(li, resultsList.firstChild);
      state = "start";
    }
    playButton.disabled = false;
  };

  playButton.addEventListener("click", () => {
    socket.send(`${state}:${uuid}`);
    playButton.disabled = true;
  });
});
