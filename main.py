from flask import Flask, render_template, request
import os

app = Flask(__name__)  # Corrected Flask instantiation

@app.route('/')
def index():
    return render_template('index.html')  # Corrected quotes

@app.route('/take_camshot', methods=['POST'])  # Corrected quotes
def take_camshot():
    os.system("mkdir camshots")  # Corrected quotes and replaced curly quotes with straight quotes
    os.system("fswebcam -r 1280x720 camshots/camshot.jpg")  # Corrected quotes
    return "Camshot taken successfully!"  # Corrected quotes

if __name__ == '__main__':  # Corrected double equal sign and '__main__'
    app.run(port=8000)
