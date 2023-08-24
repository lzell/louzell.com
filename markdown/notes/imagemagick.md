### (resize png)  
convert myimage.png -resize 50% myimage-small.png  
  
### (install imagemagick, image magic)  
brew install ghostscript  
brew install imagemagick  
  
### (imagemagick, caption, word wrap)  
http://www.rubblewebs.co.uk/imagemagick/notes/wrap.php  
  
### (imagemagick, swap white for clear, replace with transparency)  
convert image.gif -fuzz XX% -transparent white result.gif  
source: https://www.imagemagick.org/discourse-server/viewtopic.php?t=12619  
  
### (imagemagick, old)  
$ sudo port install ImageMagick  
cool method called morph for switching images in gallery  
  
### (imagemagick, old, create new image of specific size)  
create a new image of certain size  
convert -size 512x512 xc:white ~/Desktop/foo.jpg  
