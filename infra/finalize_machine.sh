#!/bin/bash
#
# Lint with:
# !shellcheck %

set -euo pipefail

red=$(tput setaf 1)
green=$(tput setaf 2)
gray=$(tput setaf 8)
reset=$(tput sgr0)

function confirm_and_run() {
  while true; do
    read -r -p "${gray}Run \"${red}$1${gray}\" (yes/no/exit) ${reset}" confirm
    if [[ $confirm == [yY] || $confirm == [yY]es ]]; then
       eval "$1"
       break
    elif [[ $confirm == [nN] || $confirm == [nN]o ]]; then
       break
    elif [[ $confirm == [eE] || $confirm == [eE]xit ]]; then
       exit 1
    fi
  done
}

confirm_and_run 'sudo mv -v /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak'
confirm_and_run 'sudo ln -sv /home/ec2-user/nginx.conf /etc/nginx/nginx.conf'
confirm_and_run 'sudo ln -sv /home/ec2-user/virtual.conf /etc/nginx/conf.d/virtual.conf'

echo -e "\n${gray}Installing certs next. Attach an elastic IP before continuing. Otherwise the letsencrypt challenges will fail.${reset}"
echo -e "\n${green}There is a limit to the number of certs that letsencrypt will issue before rate limiting. Be careful when developing to not run this over five times in two days. It's better to scp a cert from an existing location.${reset}\n"

# Cert for louzell.com
echo -e "\nAt the next prompt, enter:\nlzell11@gmail.com\ny\ny\nwww.louzell.com louzell.com www.louiszell.com louiszell.com${green}(order is important)${reset}\n"
confirm_and_run 'sudo /opt/certbot/bin/certbot certonly --standalone'
confirm_and_run 'sudo openssl dhparam -out /etc/letsencrypt/live/www.louzell.com/dhparams.pem 2048'

# Create location to serve www.louzell.com
confirm_and_run 'sudo install -do ec2-user -g ec2-user /srv/www/louzell.com'

# Append cron to existing list of crons:
confirm_and_run '(sudo crontab -l 2>/dev/null; echo "26 16 * * 0 su -lc /home/ec2-user/update_certs.sh >> /home/ec2-user/update_certs.log 2>&1") | sudo crontab -'
confirm_and_run 'sudo crontab -l'

confirm_and_run 'sudo systemctl daemon-reload'
confirm_and_run 'sudo systemctl restart crond'
confirm_and_run 'sudo systemctl enable nginx'
confirm_and_run 'sudo updatedb'
