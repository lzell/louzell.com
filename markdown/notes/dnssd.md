## How to see what a bonjour service resolves to  
  
Register with  
  
    dns-sd -R "myapp" _http._tcp . 8000  
  
Browse with  
  
    dns-sd -B _http._tcp  
  
Resolve with  
  
    dns-sd -L "myapp" _http._tcp  
  
Also check out the App Store product "Discover - DNS-SD Browser"  
A quick alternative with less detailed information is:  
  
    dns-sd -B _services._dns-sd._udp  
  
  
## How to find my MacBook's bonjour name  
  
    hostname  
    # => Lous-MacBook-Air.local  
  
  
## How to see dns-sd packets on the wire  
  
  
Start tcpdump:  
  
```  
  sudo tcpdump -i lo0 udp -vv -X -nn  
                      ^           ^  
                      |           |- Don't resolve hostnames or port names  
                      |-- dns uses UDP  
```  
  
Register the service:  
  
    dns-sd -R "Joypad Service" _joypad local 5500  
  
Notice in tcpdump the destination address 224.0.0.251 - this is the multicast address.  
Notice also the destination port 5353  
  
    sudo lsof -i -P | grep 5353  
  
Shows:   
  
    mDNSRespo   187 _mdnsresponder    7u  IPv4 0x4d1ba82cb627e84f      0t0    UDP *:5353  
    mDNSRespo   187 _mdnsresponder    8u  IPv6 0x4d1ba82cb627952f      0t0    UDP *:5353  
  
Can query the responder directly for dns records with dig (update 2024-01-27, this no longer works):  
  
    dig @224.0.0.251 -p 5353 -t ptr _joypad._tcp.local  
  
Browse for Joypad:  
  
    dns-sd -B _joypad local  
  
  
## Where on MacOS is the `dsn_sd.h` header  
  
As of Sonoma 14.2.1:  
  
`/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/dns_sd.h`  
  
or:  
  
`/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include/dns_sd.h`  
  
  
From the email with subject: "UDP Broadcast uses random source ports" Aug 31:  
  
    The most robust implementations I've seen use the API provided by this  
    header file:  
  
     "/usr/include/dns_sd.h"  
  
    ...  
  
    The "dns_sd.h" API is pretty straightforward and gets the job done.  
  
    ...  
  
    There is also a ruby gem named "dnssd" which compiles its C extension  
    against "dns_sd.h". You can browse the source code for that on github.  
