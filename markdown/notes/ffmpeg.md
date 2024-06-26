<!-- 2023-08-01 -->  
## ffmpeg notes  
  
### How to normalize and then convert mono to stereo  
  
ffmpeg -i audio.m4a -filter:a loudnorm audio1.m4a  
ffmpeg -i audio1.m4a -af "pan=stereo|c0=c0|c1=c0" audio2.m4a  
  
### How to dump metadata  
  
Try all of these to dump data from `myfile.mov`  
  
    ffprobe -show_entries 'stream_tags : format_tags' myfile.mov  
    ffprobe -v quiet -print_format json -show_streams myfile.mov  
    mdls myfile.mov  
    mp4dump myfile.mov  
    exiftool myfile.mov  
    exiftool -v<level> myfile.mov  
  
`<level>` can be 1 through 5  
mp4dump relies on the bento4 homebrew package  
exiftool relies on the exiftool homebrew package  
  
### Loudness normalization  
  
Normalize:  
  
    ffmpeg -i "IMG_0025.mov" -filter:a loudnorm output.mp4  
  
Then increase:  
  
  
 Source: https://trac.ffmpeg.org/wiki/AudioVolume  
  
### How to remove audio  
Use the `-an` flag  
  
### How to re-compress video  
  
Higher `-crf` numbers perform more compression:  
  
    ffmpeg -i input.mp4 -vcodec libx264 -crf 28 output.mp4  
  
source: https://unix.stackexchange.com/questions/28803/how-can-i-reduce-a-videos-size-with-ffmpeg  
  
### How to cut parts of video with no audio  
See https://github.com/WyattBlue/auto-editor  
  
### How to speed up a video that doesn't have audio  
  
    ffmpeg -i speedup.mov -filter:v "setpts=0.8*PTS" speedup2.mov   
  
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
  
  
### How to install ffmpeg on AL2023  
  
    wget https://ffmpeg.org/releases/ffmpeg-7.0.tar.bz2  
    tar -xjvf ffmpeg-7.0.tar.bz2  
    cd ffmpeg-7.0  
    ./configure  
    make  
    sudo make install  
    which ffmpeg  
    ffmpeg --version  
