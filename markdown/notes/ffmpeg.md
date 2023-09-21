<!-- 2023-08-01 -->  
## ffmpeg notes  
  
### How to remove audio  
Use the `-an` flag  
  
### How to re-compress video  
  
    ffmpeg -i input.mp4 -vcodec libx264 -crf 28 output.mp4  
  
source: https://unix.stackexchange.com/questions/28803/how-can-i-reduce-a-videos-size-with-ffmpeg  
  
### How to cut parts of video with no audio  
See https://github.com/WyattBlue/auto-editor  
  
### How to speed up video and audio together without affecting voices  
  
    ffmpeg -i myvid.mp4 -filter_complex "[0:v]setpts=0.5*PTS[v];[0:a]atempo=2.0[a]" -map "[v]" -map "[a]" myvid_faster.mp4  
  
Source: https://superuser.com/a/1394709/47546  
  
### How to create a video from images and audio  
  
    ./ffmpeg -f image2 -framerate 25 -i scaled/frame%08d.png -i video/audio.mp3 -r 25 -vcodec libx264 -crf 16 video/upscaled.mp4  
  
Get the framerate from the original using ffprobe.  
Source: https://www.youtube.com/watch?v=juuNQju0xv4  
See sample project in `~/dev/upscale_video`  
  
### How to get info about a video (metadata, framerate)  
  
    ffprobe myFile.mp4  
  
### How to dump video as images  
  
    ffmpeg -i video/video.mp4 frames/frame%08d.png  
  
### How to extract audio   
  
    ffmpeg -i video.mp4 audio.mp3  
  
<!-- 2023-07-02 -->  
### How to convert video to animated gif   
  
    ffmpeg -i myFile.mp4 -r 8 myFile.gif  
  
<!-- 2013-06-17 -->  
### How to splice video (tutorial, splice, slice)  
https://osric.com/chris/accidental-developer/2012/04/using-ffmpeg-to-programmatically-slice-and-splice-video/  
  
### How to install ffmpeg on MacOS  
brew install ffmpeg  
