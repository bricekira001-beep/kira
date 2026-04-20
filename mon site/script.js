document.getElementById('chatForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const input = document.getElementById('userInput');
    const message = input.value.trim();

    if (message !== "") {
        addMessage(message, 'sent');
        input.value = "";
        
        // Simulation d'une réponse automatique après 1s
        setTimeout(() => {
            addMessage("Message reçu ! 👍", 'received');
        }, 1000);
    }
});

// Gestion des fichiers (Photo/Vidéo)
document.getElementById('file-input').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = function(event) {
        if (file.type.startsWith('image/')) {
            const imgHtml = `<img src="${event.target.result}" style="max-width:100%; border-radius:5px;">`;
            addMessage(imgHtml, 'sent');
        } else if (file.type.startsWith('video/')) {
            const videoHtml = `<video src="${event.target.result}" controls style="max-width:100%; border-radius:5px;"></video>`;
            addMessage(videoHtml, 'sent');
        }
    };
    reader.readAsDataURL(file);
});

function addMessage(content, type) {
    const container = document.getElementById('messageDisplay');
    const time = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    
    const msgDiv = document.createElement('div');
    msgDiv.classList.add('message', type);
    
    msgDiv.innerHTML = `
        <p>${content}</p>
        <span class="msg-time">${time}</span>
    `;
    
    container.appendChild(msgDiv);
    
    // Scroll automatique vers le bas
    container.scrollTop = container.scrollHeight;
}