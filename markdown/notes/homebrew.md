## Homebrew notes  
  
### How to list installed packages  
  
Try these options:  
  
    brew list  
    brew list --versions  
    brew list --cask  
    brew leaves  
    brew deps --tree --installed  
    brew bundle dump && cat Brewfile && rm Brewfile  
  
source: https://apple.stackexchange.com/questions/101090/list-of-all-packages-installed-using-homebrew  
  
  
### How to list all files installed by a package  
  
Try these options:  
  
    brew list <package-name>  
    brew list --verbose mysql  
    brew ls --verbose mysql  
  
  
### How to update a package, upgrade a package  
  
    brew upgrade pyenv  
  
  
### How to replay the 'caveats' section of a package  
  
    brew info <name>  
