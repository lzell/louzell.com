## How I configure a new MacOS machine   
  
### Edits to System Settings  
<pre>  
Trackpad > Scroll & Zoom > Uncheck Natural  
         > More Gestures > Swipe between pages > Swipe with three fingers  
         > Point & Click > select Tap to Click  
Keyboard > Keyboard > Key Repeat > Fast  
                    > Delay Until Repeat > Short  
                    > Press globe key to > Show Emoji & Symbols (this makes cmd+ctrl+space work to open emoji view)  
                    > Customize Control Strip > Remove Siri  
                                              > Remove Keyboard brightness  
                                              > Remove launchpad  
                                              > Add lock screen  
                                              > Add do not disturb  
                    > Keyboard Shortcuts > Modifier Keys > Map Caps Lock to Control  
                    > Shortcuts > Select 'Use keyboard navigation to move focus between controls'  
                                > Spotlight > change 'Show Spotlight search' to opt+space (clears cmd+space for quicksilver)  
                                            > unselect 'Show Finder search window' (why? I didn't do this the last time)  
                                > App Shortcuts > Add 'Google Chrome'  
                                                    Back ctl+h  (overrides default of cmd+[, helpful for deindent in online editors)  
                                                    Forward ctrl+l (overrides default of cmd+], helpful indent in online editors)  
                                > Accessibility > Invert colors with cmd+opt+ctrl+8  
                                > Function Keys > Use F1, F2, etc. as standard function keys  
         > Text  
                    > Uncheck 'correct spelling'  
                    > Uncheck 'capitalize words'  
                    > Uncheck 'add period with double-space  
                    > Uncheck 'touch bar suggestions'  
                    > Uncheck 'use smart quotes'  
                    > Remove 'omw' from shortcuts  
Mouse > Scroll direction: Uncheck natural  
          > Secondary click > Click on right side  
          > Increase tracking speed  
              > More Gestures > Turn off Swipe between full-screen apps w/ two fingers  
  	   > Turn off mission control with double tap  
Touch ID > Add a fingerprint  
         > Use Touch ID for unlocking your Mac and password autofill  
Spotlight > Search Results > unselect all except 'Applications', 'System Preferences', and 'Definition'  
                           > unselect 'Allow Spotlight Suggestions in Look Up' (this is now called 'Siri Suggestions')  
Dock > Position on screen > Right  
     > Automatically hide and show dock  
     > Do not animate application opens  
Sound > Sound Effects > Turn down alert volume to 3/4  
Siri > Uncheck 'Enable Ask Siri'  
Display > Uncheck automatically adjust brightness  
Dock & Menu Bar > Clock  
    > Digital  
    > Use 24-hour clock  
    > Display time with seconds  
    > Show date: always  
General > Show Scroll Bars > Always  
General > Uncheck 'Allow Handoff between this Mac and your iCloud devices' for work computer  
Bluetooth > Show Bluetooth in menu bar  
Battery > Uncheck 'slightly dim the display while on battery power'  
        > Bump "Turn off display after" to 5 min  
        > Show in Menu Bar  
        > Show Percentage  
        > Put hard disks to sleep when possible: Never  
Input Sources > Uncheck 'select the previous input source'  
              > Uncheck 'select next source in input menu'  
              These shortcuts conflict with Xcode's autocomplete (ctrl+space)  
Control Center > Focus > Always Show in Menu Bar  
</pre>  
  
  
### Edits to Finder  
<pre>  
Finder > Settings > Advanced > Unselect 'Show warning before changing an extension'  
</pre>  
  
### Creating my ssh key  
  
    ssh-keygen -b 4096 -f ~/.ssh/id_rsa4096_gold -o -a 100  
    ssh-add ~/.ssh/id_rsa4096_gold  
    cat ~/.ssh/id_rsa4096_gold.pub | pbcopy  
  
Paste public key into email to myself  
Add public key to github.com/settings/keys  
Add public key remote at `~/.ssh/authorized_keys`  
Add to ~/.ssh/config  
  
    Host <my-domain>.com  
    HostName=<some-ip>  
    User=ec2-user  
    IdentityFile=~/.ssh/id_rsa4096_gold  
    Port=5083  
  
### Make Mission Control behave like Exposé, turn off Spaces  
This is the closest I can find to getting back old exposé behavior  
<pre>  
System Settings > Keyboard > Keyboard Shortcuts > Mission Control > Uncheck 'Move left a space'  
                                                                  > Uncheck 'Move right a space'  
                                                                  > Uncheck 'Switch to Desktop'  
                > Desktop & Dock > Uncheck all Spaces related options of Mission Control  
                                 > Click wallpaper to show desktop items > Only in Stage Manager (whatever that is)  
  
                > Desktop & Dock > Hot corners > set bottom left to Mission Control (don't use a top corner because the cursor will automatically expand the huge 'desktop' unnecessary bar)  
                                               > set bottom right to Desktop  
</pre>  
  
Come back to these to see if anyone helped: [link](https://apple.stackexchange.com/questions/426144/disable-spaces-shelf-in-mission-control-all-windows-expos%C3%A9)  
  
  
### Make bash the default shell  
In term:  
  
    chsh -s /bin/bash  
    echo "export BASH_SILENCE_DEPRECATION_WARNING=1" >> ~/.bash_profile  
  
  
### Fix dictionary and other apps staying in background with Term in foreground  
Open Terminal > Terminal (menu bar) > turn off 'Secure Keyboard Entry'.  
If this is on, apps like Dictionary do not come to the foreground when opened. Terminal retains focus  
  
### Improve screenshot behavior  
  
Turn off screenshot delay:  
Cmd+shift+5 > Options > uncheck 'show floating thumbnail'  
  
Turn off screenshot shadow:  
  
    defaults write com.apple.screencapture disable-shadow -bool true  
  
  
### Clone my repos for notes and snippets  
Clone my various repos for notes:  
  
    cd ~  
    git clone ssh://gitbox:/srv/git/repos/notes.git  
    cd ~/dev  
    git clone ssh://gitbox:/srv/git/repos/snippets.git  
    git clone ssh://gitbox:/srv/git/repos/system_config.git  
    cd ~  
    ln -sv /Users/lzell/dev/system_config/homedir/.vimrc /Users/lzell  
    ln -sv /Users/lzell/dev/system_config/bin /Users/lzell/bin  
    [repeat for all dotfiles in system_config/homedir]  
  
  
### Configure Term  
  
Use my saved configuration for term:  
  
    open ~/dev/system_config/lz.terminal  
  
Make terminal settings stick:  
  - Type `cmd,` to open terminal settings  
  - Select Profiles > lz  
  - Tap on "Default"  
  - Enter in shell:  
    sudo chown $(whoami):staff ~/Library/Preferences/com.apple.Terminal.plist  
  
Change /usr/local ownership:  
  sudo chown -R $(whoami):staff /usr/local/*  
  
Edit term numpad settings with `cmd,` > lz (my profile) > Advanced > Uncheck 'Allow VT100 application keypad mode'.  
If I don't do this, then 9 and 3 on my keyboard numpad have weird behavior in vim.  
  
  
### Configure Desktop  
  
Right click on desktop and select 'Show View Options'  
    Stack by: none  
    Sort by: name  
    Icon size: 32x32  
    Grid spacing: middle  
    Text size: 16  
    Label position: right  
  
  
### Install latest Xcode  
developer.apple.com/downloads/more  
  
### Install various pieces of software  
Install firefox. Follow instructions in [my firefox note](https://www.louzell.com/notes/firefox.html)  
  
Install quicksilver at https://qsapp.com/. Follow instructions at ~/notes/quicksilver.txt  
  
Install homebrew: https://brew.sh/  
Install rvm: https://rvm.io/  
  
    rvm install ruby-3.2.2  
    ruby -v  
  
Install pyenv  
  
    brew install pyenv  
    pyenv install 3.8.17  
    pyenv global 3.8.17  
    python -V  
  
  
Install with homebrew:  
  
    ack  
    ag  
    awscli  
    bash-completion  
    emacs-plus@28 --with-native-comp  
    fd  
    ffmpeg  
    fzf  
    ghostscript  
    git  
    git-gui  
    gnu-tar  
    graphviz  
    imagemagick  
    jq  
    mysql  
    nginx  
    pandoc  
    parallel  
    pyenv  
    ripgrep  
    shellcheck  
    stripe/stripe-cli/stripe  
    tmux  
    tree  
    universal-ctags  
    vim  
    wget  
    htop  
  
Install Spectacle App:  
Update: Spectacle is no longer maintained. Try Rectangle instead:  
  brew install --cask rectangle  
  Uncheck 'next display' and 'previous display' shortcuts  
  Set cmd+opt+ctrl+(direction) to left half, upper half, etc.  
  Set cmd+opt+ctrl+space to 'maximize'  
  Select "Launch Rectangle at login"  
  
Install gitx-dev, a fork of gitx that works on MacOS. (update 2022-04-12: the download page for this doesn't work anymore)  
  Once installed, GitX > Enable terminal usage  
  
Install Chrome:  
  Disable spell check at chrome://settings/languages  
  Turn off 'offer to save passwords' at chrome://settings/passwords  
  
Install cdto:  
  https://github.com/jbtule/cdto  
  Drag it into /Applications, then cmd+drag it into the finder bar  
  
Install printer software:  
  Download the "BrotherPushScanTool" from the web  
  Download the "Brother iPrint&Scan" application from the app store  
  Restart the printer  
  
See my [opensnoop notes](https://www.louzell.com/notes/opensnoop.html) for disabling SIP   
