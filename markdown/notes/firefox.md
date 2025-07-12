## Firefox notes  
  
### Shortcut reference  
------------------------------------------- -----------------------------  
Show cookies for current page               shift+F9  
Open dev tools                              cmd+opt+i or F12  
Open console                                cmd+opt+k  
View source                                 cmd+u  
Toggle bookmarks sidebar                    cmd+b  
------------------------------------------- -----------------------------  
  
[Complete list](https://firefox-source-docs.mozilla.org/devtools-user/keyboard_shortcuts/index.html#keyboard-shortcuts-opening-and-closing-tools)  
  
  
### How to view/edit stored passwords  
about:logins  
  
### How to fix a slow firefox, reset firefox  
  If fireflow slows down, punch 'refresh firefox' into the address bar.  
  Allocate a couple minutes to go through this list again:  
  
  
### How to configure firefox on a fresh install  
1. Install the following  
  * ublock origin  
  * https everywhere  
  * privacy badger  
  
2. Set up the toolbar  
  * Right click in toolbar (next to extensions) and tap "customize toolbar"  
    * Remove pocket from extensions bar  
    * Add 'extensions', 'forget', and 'developer' to the toolbar  
  
3. Hide the bookmarks toolbar with `cmd+shift+b`  
  * Firefox will remember this decision. I use the sidebar only (e.g. `cmd+b`), which has search  
    * Use `cmd-b` and then start typing to find a bookmark, then hit `tab+space+return` to browse to it  
  
4. Configure various settings  
  
  * Turn off delete or backspace as navigate backwards  
      about:config  
      set `backspace_action` to 2  
    
  * Turn off web notifications  
      about:config  
      Toggle the setting `dom.webnotifications.enabled`  
    
  * Turn off geo locations:  
      about:config  
      `geo.enabled false`  
    
  * Iterate through most recently used tabs:  
      about:config  
      `browser.ctrlTab.sortByRecentlyUsed true`  
    
  * Ublock origin block annoyances (this turns off google's login popup):  
      uBlock > Settings > Filter lists > Annoyances > AdGuard - Annoyances   
      [source](https://www.reddit.com/r/firefox/comments/y3xetn/google_popup_never_seen_before)  
    
  * Turn on the status bar with `ctrl+/`  
  
  
### How to turn off suggestions and predictions  
* Settings > Search > Search Suggestions > Uncheck provide search suggestions  
* Settings Privacy & Security > Address Bar - Firefox Suggest  
    Disable everything except 'Bookmarks' and 'Browsing history'  
    Disable 'Suggestions from the web'  
    Disable 'Suggestions from sponsors'  
  
## How to turn off chatgpt on select text  
about:config  
Set browser.ml.chat.shorcuts false  
  
  
### How to make a new tab blank   
Settings > Home > Firefox Home Content > Uncheck all except 'Recent activity > Bookmarks'  
Settings > Home > New Windows and Tabs > Blank page  
   
  
### How to adjust the YouTube playback speed beyond given limits  
Open console with cmd+shift+k and punch in:  
  
    document.getElementsByTagName("video")[0].playbackRate = 2.5  
