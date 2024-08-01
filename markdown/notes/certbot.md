<!-- 2023-04-30 -->  
### How to install certbot on AL2023  
  
To install the initial the letsencrypt certificate on Amazon Linux 2023:  
  
    dnf install python3  
    python3 -m venv /opt/certbot  
    source /opt/certbot/bin/activate  
    pip install --upgrade pip  
    pip install certbot certbot-nginx  
    certbot certonly --standalone  
    :: follow prompts  
    :: once certs are on disk, start nginx  
    systemctl start nginx.service  
  
To renew:  
  
    /opt/certbot/bin/certbot renew --nginx  
  
To perform a dry run of renew:  
  
    /opt/certbot/bin/certbot renew --nginx --dry-run --no-random-sleep-on-renew  
  
Notes:  
  
* On a fresh box, I use certbot's `--standalone` option instead of the `--nginx` option to get the initial certificate. Nginx can't start on a fresh box because the files at `/etc/letsencrypt/live/<my-domain>/` are not yet on disk (they are created by certbot).  
  
* I use the `--nginx` option for renewals, as nginx will already be configured correctly and up and running.  
  
* I don't use yum for this install because the epel repo is not supported by Amazon Linux 2023.  
  - No longer supported: `yum install certbot`  
  - No longer supported: `certbot-auto`  
  - No longer supported: `epel`  
  
Reference: https://certbot.eff.org/instructions?ws=nginx&os=pip  
  
  
### Where are letsencrypt certs stored on AL2023  
  
Certbot files are stored at  
  
    /etc/letsencrypt/archive/www.aiproxy.pro  
  
and are symlinked to  
  
    /etc/letsencrypt/live/www.aiproxy.pro  
  
  
### How to use a CSR with certbot  
  
Warning, if I usa a CSR then the `--reuse-key` flag does not work with certbot.  
I use CSRs to create backup keys in the event that something goes wrong with my   
standard `--reuse-key` automated infra. If a bug in letsencrypt causes a cert  
refresh to change the public/private key pair, then all my cert pinned clients will  
start failing. To mitigate, I create backup keys and store them in a safe location,  
and bake the public keys into the cert pinned clients.  
  
Generate an elliptic curve private key:  
  
    openssl ecparam -name prime256v1 -genkey -noout -out my-private-key.key  
  
Generate a CSR:  
  
    openssl req -new -key my-private-key.key -out beta-api.aiproxy.pro.csr  
  
Use the CSR to generate a cert:  
  
    sudo /opt/certbot/bin/certbot certonly --nginx --csr beta-api.aiproxy.pro.csr  
  
Dump the contents of the cert and verify that the public key matches what's expected:  
  
    openssl x509 -noout -text -in 0000_cert.pem  
    :: view the 'Subject Public Key Info' section, compare it to the 'pub' section of:  
    openssl ec -in my-private-key.key -text -noout  
  
Move the cert into place (do this for the beta API only)  
  
    cd /etc/letsencrypt/live/beta-api.aiproxy.pro  
    :: move the existing symlinks out of place  
    mv cert.pem cert.pem.bak  
    mv chain.pem chain.pem.bak  
    mv fullchain.pem fullchain.pem.bak  
    mv privkey.pem privkey.pem.bak  
  
    :: move new files into place  
    mv /home/ec2-user/0000_cert.pem cert.pem  
    mv /home/ec2-user/0000_chain.pem chain.pem  
    mv /home/ec2-user/0001_chain.pem fullchain.pem  
    mv /home/ec2-user/my-private-key.key privkey.pem  <-- is this right  
  
    :: restart nginx  
    systemctl restart nginx  
  
    :: verify that cert pinning works with the public pair of `my-private-key.key`  
  
  
### How to update a single domain's cert  
  
    sudo /opt/certbot/bin/certbot certonly --reuse-key --nginx -d beta-api.aiproxy.pro  
  
Verify that the private/public key pair didn't change with:  
  
    cd /etc/letsencrypt/archive/beta-api.aiproxy.pro  
    openssl ec -in privkey1.pem -text -noout  
    openssl ec -in privkey2.pem -text -noout  
  
