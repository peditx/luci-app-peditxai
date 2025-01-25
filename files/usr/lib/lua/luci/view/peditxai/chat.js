document.addEventListener("DOMContentLoaded", function () {
    const chatHistory = document.getElementById("chat-history");
    const chatMessage = document.getElementById("chat-message");
    const sendButton = document.getElementById("send-button");

    sendButton.addEventListener("click", function () {
        const message = chatMessage.value.trim();
        if (message) {
            addMessage("user", message);
            chatMessage.value = "";

            fetch("/cgi-bin/peditxai_chat.sh?message=" + encodeURIComponent(message))
                .then(response => response.text())
                .then(response => {
                    addMessage("assistant", response);
                    if (response.startsWith("Command:")) {
                        addExecuteButton(response);
                    }
                })
                .catch(error => {
                    addMessage("error", "Failed to send message.");
                });
        }
    });

    function addMessage(role, text) {
        const messageElement = document.createElement("div");
        messageElement.classList.add("chat-message", role);
        messageElement.textContent = text;
        chatHistory.appendChild(messageElement);
        chatHistory.scrollTop = chatHistory.scrollHeight;
    }

    function addExecuteButton(command) {
        const buttonElement = document.createElement("button");
        buttonElement.textContent = "Execute Command";
        buttonElement.classList.add("execute-button");
        buttonElement.addEventListener("click", function () {
            executeCommand(command);
        });
        chatHistory.appendChild(buttonElement);
    }

    function executeCommand(command) {
        fetch("/cgi-bin/peditxai_execute.sh?command=" + encodeURIComponent(command))
            .then(response => response.text())
            .then(response => {
                addMessage("executed", "Command executed: " + response);
            })
            .catch(error => {
                addMessage("error", "Failed to execute command.");
            });
    }
});
