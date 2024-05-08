from flask import Flask, render_template, request
import os

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/take_camshot', methods=['POST'])
def take_camshot():
    try:
        group_name = request.form['group_name']  # Get the group name from the form input
        
        # Create a directory with the group name to store camshots if it doesn't exist
        group_directory = f'camshots/{group_name}'
        if not os.path.exists(group_directory):
            os.makedirs(group_directory)
        
        # Capture image using fswebcam command
        os.system(f"fswebcam -r 1280x720 {group_directory}/camshot.jpg")
        
        return "Camshot taken successfully!"
    except Exception as e:
        return f"Error: {str(e)}"

if __name__ == '__main__':
    app.run(port=8000)
