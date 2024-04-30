## Redis notes  
  
### Redis dump and log location on AL2023  
  
/var/log/redis6/redis6.log  
/var/lib/redis6/dump.rdb  
  
### How to start redis on macos  
  
    brew install redis  
    redis-server  
  
### How to start redis on AL2023  
  
    sudo dfn install -y redis6  
    sudo systemctl enable redis6  
    sudo systemctl start redis6  
  
### How to shut down redis on macos  
Either ctrl-c the redis server process, or  
  
    redis-cli  
    > shutdown  
  
### How to shut down redis on AL2023  
  
    sudo systemctl stop redis6  
  
### How to show slow queries, slow log  
  
    redis-cli  
    > slowlog get 10  
  
### How to echo all commands sent to redis server  
Start the redis client with:  
  
    redis-cli monitor  
    redis6-cli monitor  
  
or  
  
    telnet localhost 6379  
    > MONITOR  
  
Use the first option.  
  
### How to get help in the redis cli  
  
    > help <tab>  
    > help @set  
  
### How to get all namespaced keys  
Don't do this in production  
  
    KEYS my:prefix:*  
  
### How to push values into a list and read them out  
  
    lpush mylist "foo1" "foo2" "foo3"  
	lrange mylist 0 -1  
  
### How to build a quick processing queue   
	lpush mylist "a" "b"  
	brpoplpush mylist processinglist 0  
    lrange processinglist 0 -1  
    # => "a"  
    lrange mylist 0 -1  
    # => "b"  
  
### How to delete a list  
      
    del mylist  
  
### How to delete all keys under a namespace  
Careful with this one.  
  
    for key in `echo 'KEYS <my-namespace>:*' | redis-cli | awk '{print $1}'`; do echo DEL $key; done | redis-cli  
  
Or wipe everything out. Be even more careful with this one:  
  
    $ redis-cli  
    > shutdown  
    > exit  
    $ locate dump.rdb  
    $ rm <location>  
