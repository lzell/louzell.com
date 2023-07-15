### (swiftUI, custom font, add font to Xcode)  
Use this list to view built in fonts for Apple's platforms:  
https://developer.apple.com/fonts/system-fonts/  
  
If a font has a gear icon next to it, it's available out-of-the-box on iOS/MacOS.  
If a font has a download icon, I need to add it manually to my Xcode project:  
  
* Open the MacOS program "Font Book"  
* Search for the font that I want  
* Right click on the font and tap 'Show in Finder'  
* Drag the ttc file into Xcode, use the 'copy item' option  
* Open the Xcode inspect panel with cmd+opt+0  
* Add the font to my target in 'target membership'  
* Tap on the project root in the Xcode project tree  
* Tap on the 'info' tab  
* Add 'Fonts provided by application'  
   * As 'item 0', add the filename of the ttf file that was dragged into Xcode  
* The custom font will now work in SwiftUI preview  
  
See [this thread](https://www.threads.net/t/Cujx_LEOS4e) for screenshots of the process.  
