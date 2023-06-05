## 2023  
<!-- 2023-05-15 -->  
### (macos, self-signed cert, https, ssl, tls, localhost, nginx, app server)  
  
Create a fake backend:  
  
    mkdir <project-dir>  
    cd <project-dir>  
    echo "hello world" >> index.html  
    python -m http.server  
    :: visit http://localhost:8000 and verify I see "hello world"  
  
Create a self-signed TLS certificate:  
  
    openssl genrsa 4096 -out localhost.key  
    openssl req -new -x509 -subj "/CN=localhost/" -addext "subjectAltName = DNS:localhost" -nodes -sha256 -key localhost.key -out localhost.pem  
  
Chrome and safari enforce TLS certs contain a subjectAltName.  
Verify there is a section called "X509v3 extensions", and that it contains "subjectAltName":  
  
    openssl x509 -noout -text -in localhost.pem  
  
Tranform the cert for MacOS Keychain:  
  
    openssl x509 -in localhost.pem -inform pem -outform der -out localhost.cer  
  
Trust the cert in keychain:  
  
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain localhost.cer  
    :: Open Keychain Access > System and double tap 'localhost'  
    :: Tap the 'Trust' chevron and verify that SSL is set to "Always Trust"  
  
Install nginx  
  
    brew install nginx  
  
Add `/opt/homebrew/etc/nginx/servers/localhost.conf` with the contents (replace `/path/to/<project-dir>`):  
  
    upstream app-server {  
      server 127.0.0.1:8000;  
    }  
  
    server {  
        listen       443 ssl;  
        server_name  localhost;  
  
        ssl_certificate      /path/to/<project-dir>/localhost.pem;  
        ssl_certificate_key  /path/to/<project-dir>/localhost.key;  
  
        ssl_session_cache    shared:SSL:1m;  
        ssl_session_timeout  5m;  
  
        ssl_ciphers  HIGH:!aNULL:!MD5;  
        ssl_prefer_server_ciphers  on;  
  
        location / {  
          proxy_set_header X-Real-IP $remote_addr;  
          proxy_set_header X_FORWARDED_PROTO https;  
          proxy_set_header X_FORWARDED_HOST $http_host;  
          proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;  
          proxy_redirect off;  
          proxy_max_temp_file_size 0;  
  
          if (!-f $request_filename) {  
              proxy_pass http://app-server;  
              break;  
          }  
       }  
    }  
  
  
Start nginx:  
  
    nginx  
  
Browse in Chrome or Safari to https://localhost (Firefox doesn't trust self signed certs)  
  
Stop nginx:  
  
    nginx -s stop  
