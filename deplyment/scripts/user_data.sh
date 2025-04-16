#!/bin/bash

# Update and install dependencies
apt-get update -y
apt-get install -y python3-pip python3-venv nodejs npm git

# ----------------------
# Set up Flask app
# ----------------------
mkdir -p /home/ubuntu/flask-app
cat <<EOF > /home/ubuntu/flask-app/app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Flask!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# Create requirements.txt for Flask
cat <<EOF > /home/ubuntu/flask-app/requirements.txt
flask
EOF

# Set up virtual environment and install Flask
cd /home/ubuntu/flask-app
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Run Flask app in background
nohup python3 app.py > flask.log 2>&1 &

# ----------------------
# Set up Express app
# ----------------------
mkdir -p /home/ubuntu/express-app
cat <<EOF > /home/ubuntu/express-app/app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from Express!');
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Express server listening on port 3000');
});
EOF

cd /home/ubuntu/express-app
npm init -y
npm install express

# Run Express app in background
nohup node app.js > express.log 2>&1 &
