<!-- 2023-06-25 -->  
### (ctags, universal, supported languages, macos)  
Do not do this: `brew install ctags`  
This is what I want: `brew install universal-ctags`  
  
### (ctags, check language support)  
`ctags ---list-kinds=all`  
  
### (ctags, create tags file)  
`ctags -R src/*`  
  
### (ctags, ignore js files, ignore node modules)  
`ctags --exclude=*.js --exclude=node_modules -R *`  
  
<!-- 2014-05-28 -->  
### (ctags, vim, cheat sheet)  
------------------------------------------- ----------------------  
Build tags (from shell)                     `ctags -R *`  
Open vim to a specific tag (from shell)     `vim -t PickupsController`   
Jump to tag                                 `ctrl+]`  
Split the window before jumping to tag      `ctrl+w ctrl+]`  
Jump to next tag                            `:tnext` or `:tn`  
See all matching tags                       `:ts`  
Show autocomplete via ctags                 `ctrl+x ctrl+]`  
------------------------------------------- ----------------------  
  
Also:  
- Add 'tags' to `.gitexcludes`  
- Add `set tags=./tags;` to `~/.vimrc`. The semi-colon means "recursively search up"  
  
<!-- 2015-09-11 -->  
### (ctags, racket, scheme)  
`ctags --language-force=scheme myfile.rkt`  
