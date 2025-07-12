## Pandoc latex to markdown  
  
    pandoc problems.tex -o problems.md  
  
See also pdflatex which comes with MacTeX. See ~/notes/latex.md  
  
<!-- 2023-06-03 -->  
### (pandoc, print default template)  
Publishing markdown to html uses a default pandoc template.  
See the contents of the default template with:  
  
    pandoc --print-default-template=html  
  
### (pandoc, add footer, html, tweak default template)  
Dump the default template to a file:  
  
    pandoc --print-default-template=html > my_template.html  
  
Make changes to the template. Then:  
  
    pandoc -f markdown -t html --standalone --template=my_template.html myfile.md   
  
<!-- 2023-05-06 -->  
### (pandoc, preserve leading whitespace, export html)   
Use the pandoc `line_blocks` extension to preserve leading whitespace when exporting markdown to html.  
  
Write markdown with a pipe prefix, e.g.  
  
    | hello  
    |   world  
  
The leading pipe needs to be in the first column of markdown.  
https://pandoc.org/MANUAL.html#extension-line_blocks  
  
### (pandoc, list all markdown extensions)  
`pandoc --list-extension=markdown`  
  
### (pandoc, automatically surround urls with anchor tags, auto link)  
Use the export option `autolink_bare-uris`, e.g.  
  
    pandoc -f markdown+autolink_bare_uris -t html --standalone myfile.md  
  
### (pandoc, markdown, newline, export, pandoc, html, vim)  
Use \n to enter two spaces at the end of a line of markdown.  
This creates a newline in the exported html.  
Good for preserving newlines in html exported with pandoc.  
  
    nnoremap <leader>n $A  <Esc>j0  
  
### (pandoc, bookmark, indentation inside list items)  
https://pandoc.org/MANUAL.html#block-content-in-list-items  
  
## 2022  
<!-- 2022-11-05 -->  
### (pandoc, markdown viewer)  
  Install pandoc:  
  
    brew install pandoc  
  
  Then from vim in a markdown file, use:  
  
    :! pandoc -f markdown -t html --standalone % > %.html && open %.html  
