#!/bin/bash
apt-get update -y
apt-get install -y python3-pip python3-venv git

mkdir -p /home/ubuntu/flask-app
cd /home/ubuntu/flask-app

cat <<EOF > app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello from Flask!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

echo "flask" > requirements.txt
python3 -m venv venv
source venv/bin/activate
pip install --break-system-packages -r requirements.txt
nohup python app.py > flask.log 2>&1 &
