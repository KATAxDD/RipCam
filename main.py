from flask import Flask, render_template, request
import os

app = Flask(name)

@app.route(‘/’)
def index():
    return render_template(‘index.html’)

@app.route(‘/take_camshot’, methods=[‘POST’])
def take_camshot():
    os.system(“mkdir camshots”)
    os.system(“fswebcam -r 1280x720 camshots/camshot.jpg”)
    return “Camshot taken successfully!”

if name == ‘main’:
    app.run(port=8000)
