## 2023  
<!-- 2023-05-25 -->  
### (ssh, disconnect from stale session)  
`~.`  
  
### (sshd log, ssh, Amazon Linux 2023)  
The ssh log is no longer at /var/log/secure.  
  
Use:  
    `journalctl -u sshd`  
  
Tail with:  
    `journalctl -fu sshd`  
  
  
### (sshd, get status, restart, Amazon Linux 2023)  
    systemctl status sshd.service  
    systemctl restart sshd.service  
  
### (sshd, change port, Amazon Linux 2023)  
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak  
    sed "/^#Port 22/i Port 5083" /etc/ssh/sshd_config | sudo tee /etc/ssh/sshd_config  
    systemctl restart sshd.service  
  
## 2015  
<!-- 2015-06-22 -->  
### (ssh, forward agent, forwardagent, setup)  
Verify that my key is found in ssh agent:  
  
    ssh-add -L  
  
If this returns "The agent has no identities", add my key with:  
  
    ssh-add -k ~/.ssh/<my-private-key>  
  
Next verify that `~/.ssh/config` contains:  
  
    Host myhost  
    ForwardAgent yes  
  
Use forward agent:  
  
    local> ssh <my-host>  
    my-host> ssh <another-host>  
  
  
<!-- 2014-01-14 -->  
### (ssh, print fingerprint, public key)  
  
    ssh-keygen -lf ~/.ssh/rsa_key.pub  
  
  
## 2014  
<!-- 2014-01-08 -->  
### (ssh, kick out user, logout session, session start and end time)  
To kick an ssh session:  
  
    who -u  
    :: Get the pid  
    kill <pid>  
  
View ssh sessions with start and end times:  
  
    last -F  
  
  
## 2013  
<!-- 2013-01-05 -->  
### (ssh, ssh-agent, add and remove keys)  
Make sure key is in ssh-agent:  
  
    ssh-add -L  
  
To remove all keys in ssh-agent:  
  
    ssh-add -D  
  
To add key to ssh-agent:  
  
    ssh-add -k <private-key>  
  
  
## 2010  
<!-- 2010-01-13 -->  
### (ssh, remote script, sudo, cleartext, no visible password)  
To use ssh to launch a remote script that uses sudo, pass the `-t` flag:  
  
    ssh -l user host -t 'sudo ls'  
  
  
## 2009  
<!-- 2009-05-15 -->  
### (ssh, debugging info)  
`ssh -vv <your-host>`  
