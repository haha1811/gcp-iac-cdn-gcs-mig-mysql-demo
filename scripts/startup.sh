#!/bin/bash
apt-get update -y
apt-get install -y nginx php-fpm php-mysql

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>GCP Static + API</title>
</head>
<body>
  <h1>Hello from GCP!</h1>
  <button onclick="callApi()">Call API</button>
  <pre id="result"></pre>

  <script>
    function callApi() {
      fetch('/api/hello.php')
        .then(res => res.text())
        .then(txt => document.getElementById('result').innerText = txt);
    }
  </script>
</body>
</html>
EOF

mkdir -p /var/www/html/api
cat <<EOF > /var/www/html/api/hello.php
<?php
echo "Hello from MIG + Nginx + PHP";
EOF

chown -R www-data:www-data /var/www/html

systemctl restart nginx
systemctl enable nginx