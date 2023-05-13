## 2023-04-30  
### (certbot, install certbot, al2023, amazon linux 2023, use python)  
  
On a fresh box, use the `--standalone` option instead of the `--nginx` option to get the initial certificate.  
Otherwise, nginx fails to start for the letsencrypt challenge because the files at `/etc/letsencrypt/live/<my-domain>/` are not yet on disk.  
Use the `--nginx` option for renewals, as nginx will already be configured correctly and up and running.  
  
For initial certificate:  
  
    dnf install python3  
    python3 -m venv /opt/certbot  
    source /opt/certbot/bin/activate  
    pip install --upgrade pip  
    pip install certbot certbot-nginx  
    certbot certonly --standalone  
    :: follow prompts  
    :: once certs are on disk, start nginx  
    systemctl start nginx.service  
  
  
For renewal:  
  
    /opt/certbot/bin/certbot renew --no-self-upgrade --standalone  
  
Test renewal with:  
  
    /opt/certbot/bin/certbot renew --nginx --dry-run --no-random-sleep-on-renew  
  
I don't use yum for this install because the epel repo is not supported by Amazon Linux 2023.  
No longer supported: `yum install certbot`  
No longer supported: `certbot-auto`  
No longer supported: `epel`  
  
Reference: https://certbot.eff.org/instructions?ws=nginx&os=pip  