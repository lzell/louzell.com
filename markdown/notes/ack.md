<!-- 2023-06-11 -->  
### (ack shortcut for ignoring js files)  
Handy for working in typescript:  
  
    ack --no-js pattern  
  
Or  
      
    ack --ts pattern  
  
### (ack ignore file, ignore directory, ignore extension)  
----------------------------    -----------------------------------------  
Ignore specific file            `ack --ignore-file=is:code.js pattern`  
Ignore specific dir             `ack --ignore-dir=is:build pattern`  
Ignore specific extension       `ack --ignore-file=ext:ipynb pattern`  
Ignore file matching pattern    `ack --ignore-file=match:/example/ pattern`  
----------------------------    ------------------------------------------  
  
I also use create a default ~/.ackrc with (warning, destructive!):  
  
    ack --create-ackrc > ~/.ackrc  
  
And then add the following additions:   
  
    --ignore-file=ext:ipynb  
    --ignore-file=ext:orig  
    --ignore-file=is:tags  
    --ignore-file=is:.byebug_history  
    --ignore-file=is:project_generated.json  
    --ignore-dir=match:/^\.env.*$  
    --ignore-dir=match:/^\.mypy_cache$  
    --ignore-dir=match:/^venv$  
    --ignore-dir=match:/^tmp$  
  
Make sure `export ACKRC=".ackrc"` is in my shell profile (`~/.bash_profile`)  
  
The `~/.ackrc` file can be supplemented with project-specific `.ackrc` files in the project root.  
  
  
### (ack in vim)  
Add `Plug 'mileszs/ack.vim'` to `~/.vimrc`, then:  
  
    :source ~/.vimrc  
    :PlugInstall  
  
Then use `:Ack pattern`  
Follow symlinks with `:Ack --follow pattern`  
  
<!-- 2021-10-11 -->  
### (ack search files with specific extension)  
If file type is built in, use:  
  
    ack --type=python searchthis  
  
If the file type is not built in (e.g. markdown), use:  
  
    ack --type-add=md:ext:md --type=md searchthis  
  
<!-- 2018-09-20 -->  
### (ack, regex group, backreference)  
Use the `--output` flag. For example, `myfile.txt` looks like this:  
  
    ab  
    abc  
    abcd  
  
Running:  
  
    ack 'a(\w+)' --output "\$1" myfile.txt  
  
Prints:  
  
    b  
    bc  
    bcd  
  
<!-- 2019-08-23 -->  
### (ack, syntax reminder)   
Use `ack --dump` for a concise reading of everything in `~/.ackrc`  
There are examples of all ways to ignore files / directories  
  
<!-- 2020-07-11 -->  
### (ack, find files instead of text)  
To find all `module.map` files in the subtree:  
  
    ack -g module.map  
  
See 'man ack' for some caveats on `ack -g`.  
It is not intended to be a general purpose file finder  
  
Works with wildcard too, for example all `yml` files that are in a `Modules` dir  
(or have `Modules` have somewhere in the path):  
  
    ack -g Modules.*yml  
  
### (ack filetype, ack pipe, ack ignore)  
To pipe found files back to ack:  
  
    ack -g module.map | ack -x -w -i darwin  
