#!/bin/bash
apt-get update -y
apt-get install -y nodejs npm git

mkdir -p /home/ubuntu/express-app
cd /home/ubuntu/express-app

cat <<EOF > app.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from Express!');
});

app.listen(3000, () => {
  console.log('Express server running on port 3000');
});
EOF

npm init -y
npm install express
nohup node app.js > express.log 2>&1 &
