### How to install ctags on MacOS  
      
    brew install universal-ctags  
  
### How to check language support for ctags  
  
    ctags ---list-kinds=all  
  
### How to create the `tags` file  
  
    ctags -R src/*  
  
### How to use ctags with typescript ignore `node_modules`  
  
    ctags --exclude=*.js --exclude=node_modules -R *  
  
### ctags cheat sheet   
------------------------------------------- ----------------------  
Build tags (from shell)                     `ctags -R *`  
Open vim to a specific tag (from shell)     `vim -t PickupsController`   
Jump to tag                                 `ctrl+]`  
Split the window before jumping to tag      `ctrl+w ctrl+]`  
Jump to next tag                            `:tnext` or `:tn`  
See all matching tags                       `:ts`  
Show autocomplete via ctags                 `ctrl+x ctrl+]`  
------------------------------------------- ----------------------  
  
### ctags gotcha  
The config file for universal ctags is different from exuberant ctags.  
The location I want for universal ctags config is `~/.ctags.d/conf.ctags` *not* `~/.ctags`.  
  
### How to use ctags with racket   
  
    ctags --language-force=scheme myfile.rkt  
  
### How to ignore `tags` files in git  
  
Add `tags` to `~/.gitexcludes`  
  
### How to configure vim for ctags  
  
Edit `~/.vimrc`:  
  
<pre>  
    "The semi-colon means "recursively search up"  
    set tags=./tags; to `~/.vimrc`.   
  
    Plug 'vim-scripts/taglist.vim'  
  
    " Show tags  
    noremap <leader>t :TlistToggle<CR>  
  
    " Reveal in taglist  
    nmap <leader><leader>t :TlistHighlightTag<CR>  
  
    " Taglist settings  
    let Tlist_Ctags_Cmd='/usr/local/bin/ctags'  
    let Tlist_Show_One_File = 1  
    let Tlist_Exit_OnlyWindow = 1  
    let Tlist_Use_SingleClick = 1  
    let Tlist_GainFocus_On_ToggleOpen = 1  
    let Tlist_Close_On_Select = 0  
    let Tlist_WinWidth = 30  
    let Tlist_Auto_Highlight_Tag = 1  
</pre>  
