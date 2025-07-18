See also `./dnssd_notes.md`  
  
## DNS tracing  
  
    dig api.aiproxy.pro +trace  
  
## Cloudflare and google both have DNS purge features  
https://dns.google/  
https://one.one.one.one/purge-cache/  
DNS checker: https://dnschecker.org/#A/api.aiproxy.pro  
  
## How to get CAA records  
  
For some reason, I have to specify the nameserver when I dig against cloudflare:  
  
    dig @venkat.ns.cloudflare.com caa aiproxy.pro +answer  
  
## How to use a specific name server with dig  
  
	dig @8.8.8.8 aiproxy.pro  
  
## How to do a basic dns lookup  
  
    dig louzell.com  
  
## How to do a reverse dns lookup  
  
    dig -x 64.34.164.21  
  
These two commands do the same thing (notice in the ptr version the IP order is swapped):  
  
    dig +noall +answer -x 3.20.251.10  
    dig +noall +answer PTR 10.251.20.3.in-addr.arpa  
  
Old serverbeach tutorial on [PTR records](https://web.archive.org/web/20080221045403/http://forums.serverbeach.com/showthread.php?t=5469)  
  
## How to get txt records  
  
    dig -t txt example.org  
  
## How to get the name servers of my host  
  
    host -t ns aiproxy.pro  
  
## How to benchmark nameservers  
  
To find fastest dns server for my local setup, use namebench (update 2024-01-27: this is no longer maintained)  
http://code.google.com/p/namebench/  
  
## How to inspect DNS resolution order on MacOS  
The only entry in the autogenerated file `/etc/resolve.conf` is `nameserver 192.168.1.1`  
See `scutil --dns` for the full list of resolvers   
