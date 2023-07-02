## 2023  
<!-- 2023-06-29 -->  
### (xcode, lldb, debugger, view image)  
It's helpful to view intermediate images when debugging image transformation code.  
  
Steps:  
- Encounter a breakpoint in transformation code  
- Tap the 'Show variables view' button in bottom right of debug area  
- Highlight the image variable  
- Press spacebar  
  
<!-- 2023-06-05 -->  
### (xcode, more shortcuts)  
Returning to Apple work. Refresher:  
  
------------------------------------------- ----------------------  
Reveal file in project tree                 `cmd+shift+j`  
Toggle project drawer                       `cmd+0`  
Toggle inspector drawer                     `cmd+opt+0`  
Navigate between headings in project drawer `cmd+1` through `cmd+9`  
Go back                                     `cmd+ctrl+left-arrow`  
Go forward                                  `cmd+ctrl+right-arrow`  
Fuzzy file search                           `cmd+shift+o`  
Toggle console                              `cmd+shift+y`  
Show autocomplete suggestions               `ctrl+space`  
Run                                         `cmd+r`  
Stop                                        `cmd+.`  
Format code (indent, reindent, format)      `ctrl+i`  
Interface builder quick add                 `cmd+shift+l`  
Interface builder toggle inspect panel      `cmd+opt+0`  
Simulator switch to dark mode               `cmd+shift+a`  
------------------------------------------- ------------------------  
  
Edits to a fresh Xcode install:  
  
    Settings > Editing > Uncheck suggest completions while typing  
                       > Uncheck use escape key to show completion suggestions  
                       > Check 'Automatically trim trailing whitespace'  
                       > Check 'Including whitespace-only lines'  
      
    Settings > Behaviors > Running > Generates Output > Uncheck 'Show debugger'  
  
  
## 2022  
<!-- 2022-04-22 -->  
### (xcode, simulator location, simulator disk location)  
  
    ~/Library/Developer/CoreSimulator  
    ~/Library/Developer/Xcode/iOS DeviceSupport  
    /Library/Developer/CoreSimulator/Profiles/Runtimes  
  
Source: https://stackoverflow.com/a/57929678/143447  
  
### (xcode, simulators, erase all, start over, simulator reset)  
In shell:  
  
    xcrun simctl shutdown all && xcrun simctl erase all  
  
  
<!-- 2021-04-26 -->  
### (xcode, build directory, change derived data location)  
File > Project Settings > Derived Data > Project-relative Location > Enter "Build"  
  
## 2020  
<!-- 2020-09-08 -->  
### (xcode, swiftui preview, toggle, turn off preview)  
Toggle preview: `cmd+opt+enter`  
Refresh preview: `cmd+opt+p`  
Show editor only: `cmd+enter`  
  
<!-- 2020-08-13 -->  
### (xcode, new xcode setup)  
Initial setup:  
  
    sudo xcode-select -switch /Applications/Xcode6-Beta5.app  
  
    Preferences > Text Editing:  
        Set:  
            Automatically trim trailing whitespace  
            Including whitespace-only lines  
        Unset:  
            Suggest completions while typing  
  
    Preferences > General:  
        Unset:  
            Show live issues  
  
    Preferences > Key Bindings:  
        Show completions: ctrl+n  // (autocomplete, suggestions)  
  
    Edit > Format > Spelling and Grammar > Uncheck 'Check spelling while typing'  
  
  
## 2018  
<!-- 2018-11-01 -->  
### (xcode, turn off noisy logs, ios simulator, simulator logs)  
  
    xcrun simctl spawn booted log config --subsystem com.apple.CoreTelephony --mode level:off  
    xcrun simctl spawn booted log config --subsystem com.apple.boringssl --mode level:off  
  
### (xcode, simulator, open url, deep link)  
  
    xcrun simctl openurl booted "https://www.example.com/content?id=2"  
    simctl openurl myapp://  
  
### (xcode, view debugger, lldb)   
  
Right click on a view and "Print description". Then use lldb with the address:  
  
    expr ((UILabel *)0x7f8ff9d102e0).text = @"Hi"  
    po ((UILabel *)0x7f8ff9d102e0).text  
  
Or  
  
    (lldb) expr UILabel *$label = (id)0x7f8ff9d102e0  
    (lldb) po $label.text  
  
After using expr to change a property of the view, I can use `CATransaction.flush()` instead of continuing within debugger to see updates.  
  
It's possible to use swift too, but obj-c is better for this:  
  
    (lldb) expr let $label = unsafeBitCast(0x7f8ff9d102e0, to: UILabel.self)  
  
Put this in ~/.lldbinit  
  
    command regex let s/(.+): (.+) = (0x[[:xdigit:]]+)/expr let $%1 = unsafeBitCast(%3, to: %2.self)/  
  
Then  
  
    (lldb) let label: UILabel = 0x7f8ff9d102e0  
    (lldb) po $label  
  
<!-- 2018-07-17 -->  
### (xcode, mute simulator, turn iOS simulator volume down)  
`cmd+down_arrow` repeatedly  
  
### (xcode, create docstring template, create comment block)  
Put cursor in method signature, then `opt+cmd+/`  
  
### (xcode, show indexing progress, show files indexed)  
Turn this on to see how far along Xcode's file indexer is:  
  
    defaults write com.apple.dt.Xcode IDEIndexerActivityShowNumericProgress -bool true  
  
### (xcode, show compilation time)  
Turn this on to see the amount of time each build takes:  
  
    defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES  
  
### (xcode, time profile)  
Add to "other swift flags" to debug long compilation times:  
  
    -Xfrontend -debug-time-function-bodies  
    -Xfrontend -warn-long-function-bodies=100  
  
  
<!-- 2018-06-26 -->  
### (xcode, open symbol split plane, assistant editor)  
`cmd+opt+click`  
  
### (xcode, run without building)  
cmd+ctrl+r  
  
### (xcode, index, turn off indexing, xcode, defaults)  
defaults write com.apple.dt.XCode "IDEIndexDisable" 1  
  
### (xcode, device logs, ios logs, xcode, crash log)  
Window > Devices and Simulators (or Cmd+Shift+2)  
Tap on connected device.  
:: Scroll up in main pane  
Tap on the "View Device Logs" button  
  
### (xcode, go to next issue)  
cmd+'  
  
<!-- 2018-06-22 -->  
### (xcode, shortcut change)  
Keybindings > All > "show completion list" set to `ctrl+n`  
  
<!-- 2018-06-06 -->  
### (xcode, rename project, perl rename, destructive, sed)  
This is how I rename a full project in Xcode.  
Check source into version control before attempting.  
In this example, I'm renaming the Xcode project 'RenameMe' to 'GreatProject':  
  
    rename s/RenameMe/GreatProject/ ./*  
    rename s/RenameMe/GreatProject/ ./GreatProject/*  
    find * -type f | LC_CTYPE=C xargs -I {} sed -i '' 's/RenameMe/GreatProject/g' '{}'  
  
## 2017  
<!-- 2017-04-10 -->  
### (xcode, vertical split, window, split, xcode, stack horizontally)  
View > Assistant Editor > Stack all views horizontally  
  
### (xcode, error about briding header, not able to find bridging header)  
Quit and restart workspace  
  
### (xcode, enable writing comments, you're shitting me)  
Punch this into shell:  
  
    sudo /usr/libexec/xpccachectl --verbose  
  
<!-- 2017-04-10 -->  
### (xcode, git, warnings, "missing from working copy")  
Disable Xcode's management of version control. Manage it myself:  
  
    Xcode > Preferences > Source Control > Disable source control  
  
### (xcode, extraneous logs, log xcode, system, `nw_socket_set_common_sockopts`)  
Go to Edit Scheme > Run > Arguments > Environment Variables and add:  
  
    Name:OS_ACTIVITY_MODE value:disable  
  
### (xcode, playground, disable automatic execution)   
Tap and hold the play button in the bottom right corner of the editor pane,  
an option will display to manually run.  
  
Next, bind the "Execute Playground" menu item to cmd+p, (this will disable print, which I don't need anyway)  
Now run the playground with `cmd+p`  
  
## 2016  
<!-- 2016-10-28 -->  
### (xcode, provisioning location, provisioning profile)  
~/Library/MobileDevice/Provisioning Profiles  
Or:  
Xcode > Preferences > Accounts > View Details  
  
<!-- 2016-08-25 -->  
### (xcode shortcut, jump to issue, jump and fix issue)  
`cmd+'` or `cmd+ctrl+'`  
  
<!-- 2016-07-11 -->  
### (xcode, shrink window, window half size, xcode window size)  
Xcode normally refuses to shrink to half my screen's width.  
I use spectacle to snap windows to half the screen, but Xcode gives me problems.  
The trick is to turn off Xcode's toolbar! Then it happily snaps to half the screen:  
Go to `View > Hide Toolbar`  
  
<!-- 2016-04-12 -->  
### (xcode, swift interface, header)  
If Xcode is showing declarations instead of full definitions,  
go to `Navigate > Jump to Original Source`  
  
### (xcode, show help shortcut)   
`cmd+shift+?`  
Then start typing for fuzzy search (for example, try 'interface')  
  
### (xcode, behavior, do nothing special when program creates output)  
Behaviors > Running > Generates Output, uncheck "show project navigator"  
  
## 2014  
<!-- 2014-10-20 -->  
### (xcode shortcuts)  
Edit scheme: `cmd+shift+,`  
Open documentation: `cmd+shift+0`  
Format code (indent, reindent, format): `ctrl+i`  
Toggle project navigator: `cmd+0`  
Stop build, stop running: `cmd+.`  
Autocomplete: `ctrl+n` (I change this from the default of `ctrl+space`)  
Hide issues and message bubbles: `cmd+ctrl+m` (this stopped working at some point)  
  
<!-- 2014-08-19 -->  
### (xcode, using xcodebuild, run app)  
Run app on simulator:  
  
    xcodebuild -configuration Debug -sdk iphonesimulator -workspace <workspace-name>.xcworkspace -scheme <scheme-name> -destination platform='iOS Simulator',OS=7.0.3,name='iPhone 5s'  
  
List schemes:  
  
    xcodebuild -configuration Debug -sdk iphonesimulator -workspace Turtle4.xcworkspace -list  
  
  
<!-- 2014-08-19 -->  
### (xcode, switch command line tools version)  
Modify the location at `Xcode > Preferences > Locations > Command Line Tools`  
  
  
## 2013  
<!-- 2013-02-13 -->  
### (xcode, switch debugger back to gdb)  
1. Cmd+opt+R  
2. Switch "debugger" to GDB  
Source: http://stackoverflow.com/a/9925360/143447  
  
## 2012  
<!-- 2012-08-27 -->  
### (xcode, toggle editor)  
Toggle between editor and assistant with `cmd+enter` and `cmd+opt+enter`  
  
  
<!-- 2012-04-23 -->  
### (xcode, hack, version hacking)  
To get a device with a more recent SDK on it than is compatible with current Xcode version, get the latest Xcode dmg and copy these directories:  
  
    /Volumes/Xcode/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs$ sudo cp -Rf iPhoneSimulator5.1.sdk /Xcode4/Platforms/iPhoneSimulator.platform/Developer/SDKs/  
  
    /Volumes/Xcode/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs$ sudo cp -Rf iPhoneOS5.1.sdk /Xcode4/Platforms/iPhoneOS.platform/Developer/SDKs/  
  
    /Volumes/Xcode/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport$ sudo cp -vRf 5.1\ \(9B176\) /Xcode4/Platforms/iPhoneOS.platform/DeviceSupport/  
  
Source: http://stackoverflow.com/questions/9649313/is-there-a-way-to-downgrade-from-ios-5-1-to-ios-5-0  
  
  
<!-- 2012-02-04 -->  
### (xcode3, template project)  
Copy an existing template to start.  
  
Mac templates are here:   
/Developer/Library/Xcode/Project Templates/Application  
  
iPhone templates are here:  
/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Project Templates/Library  
  
Create my own template at:  
~/Library/Application Support/Developer/Shared/Xcode/Project Templates/  
  
<!-- 2012-01-21 -->  
### (xcode, debugging, create global breakpoint)  
Punch `cmd+8` and then tap the little plus sign at the bottom, and tap "add symbolic breakpoint":  
  
    symbol: objc_exception_throw  
    Module: libobjc.A.dylib  
  
Then right click it and select `Move Breakpoint To > User`  
When the breakpoint hits, to get the exception message type `po $eax`  
  
Sources:  
http://jf.omnis.ch/archives/2011/04/efficient-exception-debugging-with-xcode-4.html  
http://developer.apple.com/library/mac/#technotes/tn2124/_index.html  
  
  
<!-- 2012-01-21 -->  
### (xcode, replicate results in shell)   
Use the `/bin/csh` shell to replicate commands from the "Build Results" phase.   
  
  
## 2011  
<!-- 2011-12-06 -->  
### (xcode, breakpoint on assertion)  
Go to the XCode 4 breakpoint navigator.  
Click the + button and choose "Add Symbolic Breakpoint"  
Set Symbol to:  
  
    "-[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:]"  
  
Click "Done"  
From: http://stackoverflow.com/questions/6007938/how-to-make-xcode4-stop-at-nsassert-failure  
  
<!-- 2011-10-23 -->  
### (xcode shortcuts, show header files, show interfaces)  
Switch between header files and source with `cmd+ctrl+up` and `cmd+ctrl+down`  
Navigate back and forwards with `cmd+ctrl+left` and `cmd+ctrl+right`  
  
<!-- 2011-08-15 -->  
### (xcode3, switch xcode versions)  
Switching between versions of Xcode:  
  
    ~$ sudo xcode-select -switch <location-of-xcode1>  
    ~$ sudo xcode-select -switch <location-of-xcode2>  
  
<!-- 2011-08-21 -->  
### (xcode3, sdk location on disk)  
iOS SDKs are now in `~/Developer/iPhone*/SDKs`  
  
<!-- 2011-08-21 -->  
### (xcode3, weak link a framework)  
To weak link a framework:   
  
* Double click a target   
* Go to General Tab  
* Under linked libraries, change the type from "Required" to "Weak"  
  
Or add `-weak_freamwork UIKit` to Other Linker Flags  
  
<!-- 2011-02-26 -->  
### (xcode3, modifications)  
- Start brackets on the next line for autocomplete, also remove space after if,else,etc and parenthesis:  
  
        defaults write com.apple.Xcode XCCodeSenseFormattingOptions -dict PreExpressionsSpacing  "" BlockSeparator "\n"  
  
  From: http://stackoverflow.com/questions/392749/xcode-adjusting-indentation-of-auto-generated-braces  
  
- To get 'home' and 'end' keys to move to beginning of line / end of line, go to Xcode > Preferences > Key Bindings.  
  Duplicate xcode default settings and name it 'lz'.  
  Then change "Move to end of line" and "Move to beginning of line" by double clicking on them.   
  
- Modify "Move to beginning (and end) of line extending selection" to use Shift+Home / Shift+End  
  
- Modify "Page up" and "Page down" to use the page up and page down keys (for some reason they are set to default as scroll up/down  
  
  
## 2010  
<!-- 2010-12-21 -->  
### (xcode3, step through assembly)  
Go to Run > Debugger Display > Disassembly Only, then use "step into" just like normal.  
For instance, put a breakpoint right at NSApplicationMain and start stepping through assembly to see what it does.  
  
<!-- 2010-12-14 -->  
### (xcode 3, unnecessary undo warning)  
Turn off warn before undo:  
  
    defaults write com.apple.Xcode XCShowUndoPastSaveWarning NO  
  
Source: http://borkware.com/quickies/one?topic=xcode  
  
<!-- 2010-12-18 -->  
### (xcode 3, hide project tree, hide file list)  
Hide project tree and file list:   
`cmd+opt+shift+e`  
  
Hide file list:   
`cmd+shift+e`  
  
<!-- 2010-12-18 -->  
### (xcode 3, split screen vertically)  
Hold opt and click the tiny box in the upper right under the lock icon.  
  
<!-- 2010-12-18 -->  
### (xcode 3, documentation, open class documentation)  
`opt+double click` on a symbol  
  
<!-- 2010-10-01 -->  
Rearranging stuff in xcode to match the filesystem is a pain,  
I have found this works to move all images to their own directory:  
  
1. Delete all images in the Resources group and select Move to Trash  
2. Restore everything but the project file:  
  
        git status | awk '{if ($2 == "deleted:") {print $3}}' | xargs git checkout  
  
3. Create a new directory on the file system called Images  
4. Move all png files to the images directory  
5. Drag the images directory into Xcode under the Resources group (recursively create groups must be checked)  
  
<!-- 2010-09-03 -->  
### (navigate to previous file, jump forward, jump backward)  
`shift+opt+cmd L/R arrow`  
  
<!-- 2010-06-04 -->  
### (xcode 3, sort files alphabetically)  
Select the folder to sort, click on Edit > Sort > By Name  
  
<!-- 2010-06-04 -->  
### (xcode 3, gripe, file tree out of sync)  
Do not drag and drop any file from any "group" into another group, it won't move on the filesystem and you are left with a project drawer that doesn't reflect your file structure.  
  
Instead, delete any groups you are about to change in xcode, make the changes on the file system, then go to `Add > Existing File` and make sure "recursively create groups" is selected.  
