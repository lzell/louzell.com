### (dnf, yum, update AL2023)  
When I see the message:  
  
    A newer release of "Amazon Linux" is available.  
    Run "/usr/bin/dnf check-release-update" for full release...  
  
Run this to update:  
  
    sudo /usr/bin/dnf upgrade --releasever=2023.2.20231026  
  
See current version of Amazon Linux:  
  
    rpm -q system-release  
  
### (dnf, yum, AL2023)  
`dnf` is now the preferred way to install software on AL2023.  
E.g. `dnf install <package-name>`  
  
`ls -l $(which yum)` shows that yum is symlinked to the `dnf-3` executable.  
All the commands I use below still work.  
  
### (yum, list repos)  
`sudo yum repolist all`  
  
### (yum, repo conf file location, al2023)  
`/etc/yum.repos.d/`  
  
### (yum, dnf, conf file location, al2023)  
`/etc/dnf/dnf.conf`  
  
### (yum, see enabled repos)  
`yum repolist enabled`  
  
### (yum, enable repo, disable repo, al2023)  
`dnf config-manager --set-enabled <repo-name>`  
`dnf config-manager --set-disabled <repo-name>`  
  
### (yum list installed, list installed with wildcard)  
`yum list installed`  
or  
`yum list installed "mysql*"`  
  
### (yum uninstall package, remove package)  
`yum remove <package-name>`  
  
### (yum, see installed files by package)  
`rpm -ql <package-name>`  
  
### (yum, list available packages)  
`yum list available "maria*" --enablerepo=<some-repo>`  
or  
`yum list | grep -i maria`  
  
### (yum, gpg keys location, al2023, amazon linux)  
`/etc/pki/rpm-gpg`  
  
### (yum, al2023, amazon linux, epel does not work)  
It seems `epel` is no longer compatible with Amazon Linux 2023.  
Posted on twitter here: https://twitter.com/louzell_/status/1668062601308413954  
If someone figures it out please let me know.  
It used to be possible to modify `/etc/yum.repos.d/epel.repo` and set `enabled` to 1, but that file no longer exists.  
