## About
This repo holds my notes on programming.  
I am slowly publishing notes that I've taken since 2008.  
They are published on [www.louzell.com](https://www.louzell.com)


## Project structure

### infra/
Contains scripts for launching and configuring new ec2 instances to serve www.louzell.com.

Machines are configured in two steps:

1. Using a `boostrap.userdata` file that's passed to the booting instance by aws, and run as root
2. Using a `finalize_machine.sh` script thats as ec2-user

Launch a new machine with:

    cd infra
    rake launch[micro]
    ./upload_utils.sh <public-dns-returned-from-command-above>
    ssh ec2-user@<public-dns>
    ./finalize_machine.sh

Before running the `finalize_machine` script, consider if an elastic
IP should be attached to this machine. If I plan to run certbot's
install, then the https challenge will fail unless the elastic IP that
I point the nameservers at is associated with this machine.
If I am not using certbot's challenges (and instead scp'ing certs from
an existing box) then I can proceed without attaching the elasticIP.

### generator/

Contains logic to:

1. Select notes out of my private directory and copy them here
2. Create `index.md` with a list of notes in this project
3. Convert markdown to html

Perfom all three with:

    cd generator
    rake

The output lives at `<project-dir>/www`.  
Browse the output locally with `open www/index.html`.  
Deploy to www.louzell.com with `rake deploy`.

### assets/

Contains light styling and a tiny amount of js.

### www/

Target directory for generated html


## Misc

Test the rendered markdown of this file (assumes vim):

    !pandoc -f markdown -t html % > %.html && open -a /Applications/Firefox.app %.html
