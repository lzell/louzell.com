# Vim cheat sheet  
  
## Prevent comment from improper indentation in nginx file  
Comments always want to stick to position 0, unless:  
  
    set ft=nginx  
  
## How to start vim without any plugins or configuration  
Handy for opening huge files in vim.  
  
Ignore my vimrc file and all plugins:  
  
    vim -u NONE -N  
  
## Folds cheat sheet  
  
I like to allow a single line to be folded:  
  
    set foldminlines=0  
  
Fold docstrings:  
  
    :set foldmethod=expr foldexpr=getline(v:lnum)=~'^\\s*///.*$'  
    zM  
  
Close all folds: `zM`  
Open all folds:  `zR`  
Close a single fold: `zc`  
  
Open folds as a cursor through them  
  
    set foldopen=all   <-- I actually don't like this  
  
  
:set foldmethod=manual  
  
  
## vim ack shortcuts  
  
Within the vim ack pane, type `?` to bring up all keyboard shortcuts. Press it again to toggle back.  
  
Use `:AckWindow` to search only the current window.  
  
Use `:Ack!` to search without jumping to the first result.  
  
  
## Vim hack, open files quickly  
  
    vim $(fzf)  
  
or  
  
    fd <pattern> | view -  
    :: Use `gf` on file I want  
  
## Vim gotcha, greedy matching with +  
  
I need to escape the `+` for matching to work as I expect:  
  
    grafana-[a-f0-9]\+  
  
I still don't understand why I can't do something like this:  
  
    grafana-[a-f\d]\+  
  
This question led me to discover `perldo`: https://stackoverflow.com/a/13476392/143447  
  
Which is neat, but I lose the interactive highlighting  
      
  
## Vim delete to matching brace  
A nice trick to eliminate a whole branch in confusing code is to place  
the cursor on opening brace, then `S-v %` to jump to the matching brace in a  
visual selection, then `d`.  
  
  
## Vim gotcha, undofile not working  
  
Make sure to create the undo dir manually. Vim won't automatically create it.  
  
    mkdir ~/.vim/undo  
  
Then, set this in `~/.vimrc`  
  
    set undofile  
    set undodir=~/.vim/undo/  
  
This will make undo span multiple vim sessions.  
Closing and re-opening vim won't interfere with undo history.  
  
  
## How to delete to the end of the line from cursor  
`D` in normal mode  
  
## How to use marks  
- Use `m{A-Za-z}` to set a mark  
- The capital marks are global and lower case local  
- I tend to use `ma` for local and `mA` for global  
- For an `a` mark, jump to it with `'a`  
  
  
## How to record and repeat a macro  
  
- Start recording in normal mode using `qq`, end recording `<Esc> q`   
- The macro is in register q, run it with `@q`  
- Run subsequent times with `@@`  
  
  
## How to use ctags with vim  
Build tags for macOS with:  
  
    brew install universal-ctags  
    cd <my-proj>  
    ctags -R *  
  
Add `tags` to `~/.gitexcludes`  
  
Modify `~/.vimrc` to contain:  
  
    Plug 'vim-scripts/taglist.vim'  
    set tags=./tags;  
    noremap <leader>t :TlistToggle<CR>  
  
In vim:  
- Use `\t` to toggle the tag list  
- Use `C-]` to jump to a tag   
- Use `C-w C-]` to split the window before jumping to tag  
- Use `:tn` to go to the next tag and `:tp` for previous  
- Use `:ta <tagname>` to jump to a tag (supports autocomplete)  
- Use `vim -t <tagname>` to start vim at a tag  
- Use `:ts` to see a list of matching tags, or `:ts <tagname>`  
  
In taglist, use `s` to sort symbol list alphabetically, and `s` again to undo.  
  
  
  
## Autocomplete cheat sheet  
- `ctrl-space` to show keyword completion (I map this for consistency with Xcode)  
- `ctrl-x ctrl-]` to show autocomplete via ctags  
- `ctrl-n` to move one completion down  
- `ctrl-p` to move one completion up  
- `enter` to accept (or `ctrl-y`, or `ctrl-e`)  
  
  
## How to increment numbers and decrement numbers  
In normal mode or visual mode  
increment with `C-a`  
Decrement with `C-x`  
  
Increment all these to 2 by visually selecting them and then `C-a`  
  
    1  
    1  
    1  
  
Increment these to 2,3,4 by visually selecting them and then `g C-a`  
  
    1  
    1  
    1  
  
  
## How to use fzf with vim   
Open a file in vim that I've fuzzy matched using fzf:  
  
    vim $(fzf)  
  
  
## How to open the current directory in Finder from vim  
  
    :! open %:p:h  
  
  
## How to find which version of python vim was compiled with:  
  
    :py3 import sys; print(sys.version)  
  
Which spit out  
    3.12.3 (main, Apr  9 2024, 08:09:14) [Clang 15.0.0 (clang-1500.3.9.4)]  
  
Can also use `vim --version` and look at `-L/opt/homebrew/opt/python@3.12` line.  
  
I modified the 3.12 environment myself with:  
  
    /opt/homebrew/opt/python@3.12/bin (stable) $ ./pip3 install ollama --break-system-packages  
  
  
  
## How to check the file encoding of a file  
  
    :set fileencoding  
  
  
## How to format json of a visual selection  
Create the visual selection, then  
  
    !jq .  
  
  
## How to format full json file  
Careful, this is destructive.  
Open json file in vim, then  
    :%!python -m json.tool  
Or  
    :%!jq  
  
  
## How to call a function I've defined in ~/.vimrc  
`:call TrimWhiteSpace()`  
  
  
## How to turn off auto-indent  
Some plugins set the `indentexpr` variable  
Investigate it with `:set indentexpr?`  
Turn it off with `:set indentexpr=`  
  
  
## How to open the command line window  
In normal mode, use `q:`  
If already in command mode, use `C-f`   
  
  
## How to move to beginning of line in command mode  
`C-e` works to move to the end of line in command mode,  
but `C-a` does not move to the start by default.  
  
Use:  
  
    cnoremap <C-a> <Home>  
    cnoremap <C-e> <End>  
    cnoremap <C-p> <Up>  
    cnoremap <C-n> <Down>  
    " cnoremap <C-b> <Left>  
    " cnoremap <C-f> <Right>  
    " cnoremap <M-b> <S-Left>  
    " cnoremap <M-f> <S-Right>  
  
I don't use the `<M-b>` and `<M-f>` shortcuts, and prefer the default  
`<S-Left>` and `<S-Right>` settings, which I also change in my `.bash_profile`  
to navigate left and right by a word.  
  
I also don't use `C-f` because it breaks a handy feature of vim.  
If already in command mode, `C-f` opens the full command window.  
  
Sources:  
https://superuser.com/a/1100910/47546   
https://stackoverflow.com/a/6923282/143447  
  
  
## How to sort lines  
I use a visual selection and then `:sort`  
  
  
## How to run the current file being edited  
Use the `%`, for example:  
  
    !clear && python %  
  
  
## Nerdtree cheat sheet  
  
* To add a file: press `m` then `a`, use a forward slash to specify directory  
* To delete a file: `m` then `d`  
* To copy a file: press `m` then `c`  
* Open a buffer without losing focus: `go`  
* Use 't' to open a new tab editing what is under the cursor  
* Toggle nerdtree by typing `:NERDTreeToggle` (I map this to `C-n`)    
* Within nerdtree, open a file in vertical split with `s`  
* Reveal in nerdtree using `:NERDTreeFind` (I map this to `\r`)  
* Show hidden files with `I`  
* Remember `?` for more  
  
  
## How to use vim-surround  
  
Surround word under cursor with quotes: `ysiw"`  
Change the surrounding from single to double quotes: `cs'"`   
Delete the single quotes surrounding: `ds'`   
  
  
## How to use easymotion  
I use easymotion for jumping to a specific word in the window.  
I find it works better than incremental search because I already have my eye on  
where I want to go. Sometimes with incremental search I fat finger a character  
and the buffer jumps to an odd location and then I'm disoriented.  
  
I use easymotion and map   
  
    nmap <Leader>s <Plug>(easymotion-sn)  
  
Then use `\s` and start typing.  
I also sometimes use `\\f` if I want to jump to a specific character that is  
not in the same line as my cursor.  
  
  
## How to show a vertical column as a wrap guide   
  
Turn on with `:set colorcolumn=110`  
Turn off with `set colorcolumn=0`  
  
  
## Tabs cheat sheet  
I don't use tabs often.  
- The thing at the top is called the tabline  
- Create a new tab with `:tabnew`  
- Switch between tabs with `gt` or `:tabn` `:tabp`  
  
It's enticing to use `set autochdir` when working with tabs, but I leave it off because I lose all rails.vim shortcuts.  
  
  
## How to get started  
Run `vimtutor`  
  
  
## How to show all tab matches in command mode  
Normally when I'm in command mode and press tab I get a single completion at a time.  
Add this to `~/.vimrc`  
  
    set wildmode=longest,list  
  
then when I use `:e pattern<Tab>` I get a command buffer with height to acccommodate all matches.  
  
I use this less, though, now that `ctrl-p` is in my fingertips.  
  
  
## How to see the full directory  
`:e .`  
  
Or use nerdtree  
  
  
## How to change the working directory to file's directory  
  
    :cd %:h  
  
Note: this changes the working directory for all tabs  
  
  
## How to save your wrist on macOS  
  
    Settings > Keyboard > Keyboard Shortcuts > Modifier Keys > map caps lock to control  
  
  
## How to use escape alternatives  
  
Once you have mapped caps lock to control, `C-[` is a viable alternative for escape.  
I also map escape to `jj` in insert mode:  
  
    imap jj <Esc>  
  
`C-c` also works as escape in insert mode out of the box.  
  
  
## How to view the output of a command in vim  
Pipe to `view -`, e.g. `ps aux | view -`  
  
  
## How to replace text up to a specific character  
`cf a` will delete upto and including the next 'a' and drop you in insert mode  
`ct a` will delete upto the next 'a' and drop you in insert mode  
  
These are special cases of movement with `f`,`F`,`t`,`T`  
Repeat with `;` (forward) or `,` backwards  
  
  
## How to repeat deletes  
Similar to the tip above, use `dta` to delete to the 'a', then `d;` to repeat in forward direction.  
  
  
## How to replace a full line  
`cc` deletes the full line and drops you in insert mode  
  
  
## How to split windows  
`:sp` splits windows horizontally  
`:vsp` splits windows vertically  
`:vsp <my-file>` splits windows and opens the my-file  
`ctrl-ww` moves between views  
`C-w r` swaps the order of split windows  
  
  
## How to resize windows  
  
    :vertical resize 80  
    :vertical resize +5  
    :vertical resize -5  
  
I use the following mappings:  
  
    nmap <Leader>= :vertical resize +5<CR>  
    nmap <Leader>- :vertical resize -5<CR>  
  
  
## How to move between windows  
  
Move left one pane: `C-w h`  
Move right one pane: `C-w l`  
Move down one pane: `C-w j`  
move up one pane: `C-w k`  
  
If I only have two panes open, it's easy to move between them with `C-w w`  
  
  
  
  
## How to navigate buffers  
Toggle between the two most recent buffers with `C-Shift-6`  
Move forward a buffer with tab key or `:bn` or hammer `ctrl-i`  
Move backward with `:bp` hammer `ctrl-o`  
  
To open a buffer window, I use a simple mapping in ~/.vimrc on `\bb`  
  
    nmap <Leader>bb :ls<CR>:buffer<Space>  
  
A nice plugin is also `bufexplorer`:  
Install with `Plug 'jlanzarotta/bufexplorer'`  
Open bufexplorer with `\be`  
Navigate with normal motion, press enter to open a buffer  
  
Can also use vanilla vim feature:  
  
	:b start-typing-and-hit-tab-for-fuzzy-search  
	:bn  
	:bp  
  
  
## How to use matchit  
`%` is the matchit power key. It can:  
- match end of function/method  
- cycle through if/then/else branches  
- match html tags such as `<div>` with `</div>`  
- match open and close parens (this is built into vim and does not depend on matchit)  
  
Use `:help matchit`  
  
The modern equivalent looks to be `vim-matchup`   
  
  
## Rails vim stuff  
Outdated, I believe. I think all of these start with `E` now:  
:R will switch between controller and view  
:Rprev will open up browser  
:Rserver starts mongrel  
:Rserver! restarts it  
:Rserver!- stops it  
  
## How to jump to a file  
Use `gf` to jump to file under cursor.  
Works with rails partials if vim rails is installed.  
  
## How to jump to dependencies in ruby  
  
A good trick with ctags is to symlink actionpack and then run ctags again, this  
way I can jump to view helpers  
  
  
## How to reload ~/.vimrc  
  
    :source ~/.vimrc  
  
  
## How to jump to a line    
Jump to line 30 with `:30` or `30G`  
  
  
## How to make the meta key work on macOS  
Go to Terminal > Settings > Profiles > Keyboard > Use option as meta key  
  
  
## How to use vimgrep  
I mainly use ack.vim, but it can be handy:  
  
    :vimgrep PATTERN **/*.erb  
  
open results with `:copen`  
Move between results `:cprev` or `:cnext`  
  
  
## How to repeat a movement  
Only certain motions can be repeated.  
Using `f`,`F`,`t`, or `T` movements can be repeated with `;` to move forwards or `,` to move backwards  
  
  
## How to move to the last edited line  
      
    '.  
  
## How to move to the last edited position  
  
    `.  
  
  
## How to move to the next occurrence of the word under the cursor  
Forward: `*`  
Backward: `#`  
  
## How to toggle numbers and relative numbers  
Turn on numbers: `:set nu`  
Turn off numbers: `:set nonu`  
Turn on relative numbers: `:set rnu`  
Turn off relative numbers: `:set nornu`  
  
  
## How to move a paragraph at a time  
Down: `}`  
Up: `{`  
  
  
## How to toggle invisibles  
  
    :set list  
    :set nolist  
  
  
## How to reformat text  
In visual mode, use `=`  
  
  
## How to convert to uppercase   
Toggle a single character in normal mode with `~`  
Convert to uppercase in visual mode with `U`  
Convert to lowercase in visual mode with `u`  
  
  
## How to retab a file from tabs to spaces  
  
    :set expandtab  
    :%retab!  
  
  
## How to remove whitespace at the end of every line  
  
    :%s/\s\+$//g  
  
  
## How to search and replace in a visual selection  
Type `S-v` and select  
then type `:s/$/,/` to replace all end of lines with a comma  
  
  
## How to use regex backreferences in find and replace  
Note the backreference `\1`. This will change 'xyzfoo' to 'barxyz'  
  
    :s/\(.*\)foo/bar\1/  
  
  
Can also use tricks like converting the matched backreference to uppercase.  
This will change 'xyzfoo' to 'barXYZ'  
  
    :s/\(.*\)foo/bar\U\1/  
  
  
## How to search and replace   
I use visual mode and select an area that I want to search/replace in, then:  
  
    :s/foo/bar/g  
  
If I want to replace all instances in a whole file (with confirmation), I use:  
  
    %s/foo/bar/gc  
  
Collection of search and replace tips: http://vim.wikia.com/wiki/Search_and_replace  
How to use a regex and incsearch in search and replace: http://stackoverflow.com/a/1295244/143447  
  
  
## How to insert a newline as part of a substitution command  
Use `\r`. For example, to turn spaces into newlines:  
  
    s/ /\r/g  
  
  
## How to bulk rename files with vim  
Plug 'qpkorr/vim-renamer'  
Open a directory with vim, then type `:Renamer`  
Make modifications, then type `:Ren`  
  
  
## How to enter a new line below current line  
Normal mode: `o`  
Insert mode: `C-o o`  
  
`C-o o` is a special case of a general pattern: use `C-o` to temporarily leave insert mode.  
  
  
## How to turn off autocommenting  
I wanted to turn autocommenting off, the feature that adds a new comment on a newline if you hit enter in an existing comment.  
Added to `~/.vim/after/ftplugin/ruby.vim`:  
  
    set fo=cql  
  
Used this to determine what was overwriting my vimrc settings:  
  
    :verbose set fo  
  
  
## In what order does vim load certain settings?  
`:help startup`  
  
  
## How to search with ack   
I use `Plug 'mileszs/ack.vim'`  
  
Use it and follow symlinks:  
:Ack --follow 'pattern'  
  
Use it with a certain filetype:  
:Ack --csharp 'pattern'  
  
  
## How to delete without copying deleted text to register  
I often yank in normal mode, then `x` or `d` something, then go to paste and paste the wrong thing.  
  
Three solutions:  
1. Use `vim-scripts/YankRing.vim` and punch `C-k` after pasting  
2. Remember to use `gv` after deleting and yank again  
3. Delete without copying text with `"_d`  
  
I use 1. Paste something with p, then hit ctrl+k and ctrl+j to cycle through options. Set:  
  
    let g:yankring_replace_n_pkey = '<c-k>'  
    let g:yankring_replace_n_nkey = '<c-j>'  
  
Discussion: http://stackoverflow.com/questions/54255/i-vim-is-there-a-way-to-delete-without-putting-text-in-the-register  
  
  
## How to combine yank with motion  
Yank to the end of the line with `y$`  
Yank word under cursor with `yiw`  
Yank whole line with `Y`  
  
## How to paste a specific yanked register  
In insert mode, paste register zero with: `C-r C-p 0`  
  
  
## How to do a visual block selection of ragged line endings  
  
    C-v  
    2j  
    $  
  
  
## Vim gotcha, how to do subsitution only within a visual selection  
By default, `:s`  operators on an entire line, which often trips me up. I make a visual  
selection of a partial line, then try a substitution, and the substitution applies to the whole  
line!  
  
The trick is to use `\%V` in the subsitution. For example, to convert the first  
two underscores to plus signs:  
  
    a_b_c_d  
    e_f_g_h  
  
place the cusor on `a` and then type `C-v j 3l` then:  
  
    :s/\%V_/+/g  
  
Or one that I use often for Swift work is to convert snake case to camelCase but only for part  
of the line (useful for CodingKeys):  
  
    :s/\%V\(_\)\(\w\)/\u\2/g  
      
  
## How to reselect the previous visual selection  
`gv`  
  
  
## How to undo  
Normal mode undo: u  
Normal mode redo: `C-r`  
Insert mode undo: `ctrl-u`  
Also see `undotree` for much more power and control.  
  
## How to background and foreground vim  
I tend to do this more on accident than on purpose.   
  
- Return to shell with `ctrl+z`  
- Return to vim with `fg`  
  
If I suddenly see:  
  
    [1]+  Stopped                 vim  
  
Enter `fg` to bring the vim process back to the foreground.  
  
  
## How to toggle case sensitivity  
I do this for case insensitive searching, or when using find and replace:  
  
    set :ic  
    set :noic  
  
  
## How to force save afile that I've opened as read-only  
`:w !sudo tee %`  
  
  
## How to set a filetype to get syntax highlighting  
For example, apache conf files don't always show up highlighted in vim  
  
    :setf apache  
  
  
## How to jump to a symbol when opening vim  
  
    ctags -R *  
    vim -t MyType  
  
## How to open two files split  
Split vertically: `vim -O a b`  
Split horizontally: `vim -o a b`  
  
## How to toggle highlighted search results  
`set :hls` or `set :nohls`  
I use <leader>h to toggle:  
  
    nmap <leader>h :set invhls<cr>  
  
## How to replace text across multiple lines with a visual selection  
ctrl+v {movement} s <type some stuff> <Esc>  
  
  
## How to switch between header files and implementation files  
Jump to header file with: `:e %<.h`  
Jump to implementation file with: `:e %<.m`  
Split header and implementation: `:vsp %<.h`  
  
  
## How to toggle word wrap behavior  
:set wrap  
:set nowrap  
  
## How to set a maximum line width  
`:set tw=110`  
  
## How to reformat text to satisfy new line width  
- I use visual mode to select text and then `gq`  
- In normal mode use `gq}` and then `.` to repeat for additional paragraphs  
  
  
## How to refresh the `ctrl-p` plugin  
I often run into a stale file list in ctrl-p. Use F5 to refresh  
  
  
## How to ignore `node_modules` with `ctrl-p`  
  
    let g:ctrlp_custom_ignore = 'node_modules'  
  
  
  
## How to paste text to the command line  
I often need to yank text (e.g. `yiw`) and paste it to the command line:  
  
Yank some text with `y`  
Open command line with `:`  
Use `C-r "` to paste it  
  
  
## How to paste the text under the cursor to the command line  
  
There is a shorter way than the approach above. Place the cursor on a word and `:C-r-w`. Do not let go of control between the `r` and `w`.  
`:C-r-f` also seems to work  
  
  
## How to copy to system clipboard  
  
Copy to system clipboard in visual mode: `"=y`  
Paste from system clipboard in normal mode: `"=p`  
Paste from system clipboard in insert mode: `cmd-v`  
Paste from system clipboard with better formatting: `C-r C-p *`  
  
I no longer use these, maybe vim versions improved pasting:  
  
    :set paste  
    :set nopaste  
  
Paste in normal mode:  
  
      :r! cat  
      <paste in contents>  
      C-d  
  
  
## How to check the current value of a vim setting  
Append a question mark. For example, `:set statusline?`  
  
## How to find which plugin is touching my variable   
For example, to find what is touching `textwidth`, use:  
  
    :verbose set textwidth?  
  
## How to align assignments on an equals sign  
Get the tabular plugin. I use `Plug 'godlygeek/tabular'`  
Then, to align text on equals:  
  
    :Tab /=  
  
  
## How to use spellcheck  
Turn on spellcheck with `:set spell`  
Turn off spellcheck with `:set nospell`  
Move between words with `]s` or `[s`  
Suggest fixes with `zs`  
Add a word to dictionary with `zg`  
Undo add with `zug`  
  
  
## How to comment and uncomment code  
I use `\c` to toggle comments using `Plug 'tomtom/tcomment_vim'`  
  
    vmap <nowait> <leader>c :TComment<CR>  
  
  
## How to modify ultisnips  
- Use `:UltiSnipsEdit` to edit the snippet definition file (or \s now) for the filetype of the currently opened file  
- Use `tab` and `shift+tab` to move between placeholders in snippet   
- I wiped out all the built in definitions that were in `~/.vim/bundle/ultisnips/UltiSnips`  
- `:help ultisnips` for more  
  
## How to see all loaded plugins  
`:scriptnames`  
source: http://stackoverflow.com/a/48952/143447  
  
  
## How to indent  
I usually use visual block mode, where indent and deindent is a single `>` or `<`, e.g.:  
  
    ctrl-v  
    j  
    >  
  
In normal mode use `>>` or `<<`.  
Can also put a count in front of it, e.g. `5>>`  
  
In insert mode, use `ctrl-i` and `ctrl-d`  
  
  
## How to select the word under the cursor  
I prefer `viw` because you the cursor can be anywhere within the word, then `y` to yank.  
  
  
## How to move the viewport without moving the cursor  
  
Scroll without the cursor moving:  
  
Move viewport up: `C-e`  
Move viewport down: `C-y`  
Move viewport so that cursor is in center: `zz`  
Move viewport so that cursor is at top: `zt`  
Move viewport so that cursor is at bottom: `zb`  
  
  
## How to scroll  
Scroll half page up, moving cursor: `C-u`  
Scroll half page down, moving cursor: `C-d`  
  
  
## How to profile vim  
  
    :profile start profile.log  
    :profile func *  
    :profile file *  
    " At this point do slow actions  
    :profile pause  
    :noautocmd qall!  
  
source: http://stackoverflow.com/questions/12213597/how-to-see-which-plugins-are-making-vim-slow/12216578#12216578  
  
  
## How to pull up documentation  
  
I believe `S-k` is supposed to do this, but I use `S-k` for a project wide  
search of word under the cursor. Should find a new mapping for that.  
  
## How to view help of all commands  
  
    :help index  
  
Then navigate with ctags-like navigation (use ctrl-] to follow a highlighted tag)  
  
  
## How to determine if vim recognizes your keystroke  
In insert mode, use `ctrl-v` then punch the key combination.  
Try it with `ctrl-v ctrl-rightArrow`  
  
  
### How to move backwards and forwards by a word in normal mode  
forward by first character of each word: `w`  
backward by first character of each word: `b`  
forward by last character of each word: `e`  
  
  
### How to move backwards and forwards by a word in insert mode  
  
    ctrl-leftArrow  
    ctrl-rightArrow  
  
or  
  
    shift-leftArrow  
    shift-rightArrow  
  
I don't think I did anything special to set that up.  
  
  
### How to find key representation to map   
In insert mode, hit `ctrl-k` and then type a key to see how to map it.  
E.g., hit ctrl-k and then backspace, vim will output <BS>  
  
  
### Code completions  
I map ctrl-space to ctlr-n so that autocomplete is the same between Xcode and vim  
  
    inoremap <c-@> <c-n>  
