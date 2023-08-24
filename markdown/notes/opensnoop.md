## 2023  
<!-- 2023-05-23 -->  
### (opensnoop, watch by process name)  
  
    opensnoop -n MyApp  
  
### (opensnoop, install, Amazon Linux 2023)  
  
    dfn install -y bcc-tools  
    updatedb  
    locate opensnoop  
    /usr/share/bcc/tools/opensnoop  
  
### (opensnoop, enable dtrace on macos, bookmark, sip, csrutil)  
https://stackoverflow.com/a/60910410/143447  
  
How to make opensnoop work with macos Sonoma:  
  
- Hold the power key to boot into recovery OS  
- When the picture of the boot volume appears next to 'Options', tap on 'Options'  
- Open Utilities > Terminal  
  
csrutil disable  
csrutil enable --without dtrace  
  
Reboot  
  
## 2021  
<!-- 2021-06-28 -->  
### (macos, built-in dtrace scripts)  
Find all built-in dtrace files on MacOS with:  
  
    find /usr/bin -name '*.d'  
  
source: https://www.youtube.com/watch?v=1OMX69KOhGg   
  
### (dtrace, bookmark)  
https://github.com/brendangregg/DTrace-book-scripts  
  
Also lookup `dtruss`  
  
## 2016  
<!-- 2016-01-16 -->  
### (opensnoop's cousin, iosnoop, bookmark)  
https://www.brendangregg.com/blog/2014-07-16/iosnoop-for-linux.html  
  
## 2012  
<!-- 2012-03-26 -->  
### (opensnoop, dtrace, bookmark)  
http://dtrace.org/blogs/brendan/2011/10/10/top-10-dtrace-scripts-for-mac-os-x/  
  
## 2010  
<!-- 2010-12-06 -->  
### (opensnoop, snow leopard, what is a program installing)  
Option 1:  
  
    sudo mdutil -a -i off  # Turns off mds  
    sudo opensnoop  
    :: Do the intall  
  
Option 2:  
    
    touch /tmp/foo  
    :: Do the install  
    sudo find /Volumes/HD2 -type -f -newer /tmp/foo  
  
  
  
