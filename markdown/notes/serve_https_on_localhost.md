<!-- 2023-05-15 -->  
### How to serve a backend app over https on MacOS  
  
I use this technique to host an app server locally on MacOS using nginx and  
self-signed certificates:  
  
#### Create a fake backend:  
  
    mkdir <project-dir>  
    cd <project-dir>  
    echo "hello world" >> index.html  
    python -m http.server  
    :: visit http://localhost:8000 and verify I see "hello world"  
  
#### Create a self-signed TLS certificate:  
  
    openssl genrsa -out localhost.key 4096  
    openssl req -new -x509 -subj "/CN=localhost/" -addext "subjectAltName = DNS:localhost" -nodes -sha256 -key localhost.key -out localhost.pem  
  
Chrome and safari enforce TLS certs contain a subjectAltName.  
Verify there is a section called "X509v3 extensions", and that it contains "subjectAltName":  
  
    openssl x509 -noout -text -in localhost.pem  
  
#### Tranform the cert for MacOS Keychain:  
  
    openssl x509 -in localhost.pem -inform pem -outform der -out localhost.cer  
  
#### Trust the cert in keychain:  
  
    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain localhost.cer  
    :: Open Keychain Access > System and double tap 'localhost'  
    :: Tap the 'Trust' chevron and verify that SSL is set to "Always Trust"  
  
#### Trust the cert in iOS simulator (optional)  
  
If I am building an iOS app, drag `localhost.cer` on to the iOS simulator, and then trust it at `Settings > General > About > Certificate Trust Settings > "Enable Full Trust for Root Certificates"`  
  
#### Configure nginx  
  
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
  
Debug by tailing logs at `/opt/homebrew/var/log/nginx/*`  
Also see config at `/opt/homebrew/etc/nginx/nginx.conf`  
  
  
### Optional: Create a root cert to serve from an IP address  
  
This works to make a request to an IP over https from safari and curl on MacOS but NOT from mobile safari on iOS nor chrome on MacOS:  
  
    openssl req -x509 -nodes -newkey rsa:2048 -keyout myrootCA.key -out myrootCA.pem -days 365 -subj "/CN=192.168.1.4"  
  
I fiddled with this for a while trying to get it to work with iOS, taking these steps:  
  
    airdrop myrootCA.pem to iOS  
    Go to settings > General > VPN & Device Management > Configuration Profile > 192.168.1.4 > Install  
    Go to settings > General > About > Certificate Trust Settings > Enable Full Trust For Root Certificates > Toggle trust slider  
  
If the 'Enable Full Trust For Root Certificates' option is not there, it's because iOS isn't happy with how the cert was generated.  
Still, once iOS Setting was happy with it, I still couldn't use mobile safari to browse to https://192.168.1.4  
  
I also tried this, which is accepted by MacOS safari and chrome, but is not accepted by iOS settings (the 'Enable Full Trust for Root Certificate' option is not present)  
  
    openssl req -x509 -nodes -newkey rsa:2048 -keyout myrootCA.key -out myrootCA.pem -days 365 -subj "/CN=192.168.1.4" -extensions SAN -config <(echo "[SAN]"; echo "subjectAltName=IP:192.168.1.4")  
