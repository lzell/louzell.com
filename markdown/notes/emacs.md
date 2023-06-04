## 2023-05-24  
### (emacs, org mode, todo, move items up and down)  
  M-up  
  M-down  
  
## 2023-05-12  
### (emacs, org mode, sort todo list by todo status)  
  :: Highlight the list to sort using C-space and movement keys  
  C-c ^ o  
  
### (emacs, org mode, sort checklist by completion status)  
  :: Place the cursor anywhere in checklist  
  C-c ^ x  
  
### (emacs, org mode, add deadline to todo item)  
  C-c C-d  
  
## 2023-05-07  
### (emacs, read changed file from disk, reload buffer)  
  M-x revert-buffer  
  
### (emacs, org-mode todo, cheatsheet)  
  - Move around with emacs key bindings  
  - Rotate status of a todo item with `C-c C-t`  
  - Rotate status of a checklist item with `C-c C-c` (I use checklists below TODOs)  
  - Add `[%]` to the end of a parent todo (one that has a checklist as children) for org-mode to show completion percentage of children  
  - Change style of checklist with `S-RightArrow`  
  - Archive done items with `C-c C-x C-a`  
  - Insert new checklist item with `M-S-RET` (this doesn't work in my setup, not sure why, but for now I'll type the new `[ ]`)  
  
  References:  
  https://orgmode.org/guide/Plain-Lists.html  
  https://orgmode.org/manual/TODO-Basics.html  
  https://orgmode.org/manual/Checkboxes.html  
  
### (emacs moves reminder)  
   - Move previous, next, forward, back with C-p, C-n, C-f, C-b  
   - Move to beginning of line, end of line with C-a, C-e  
   - Delete current line with C-a C-k C-k  
   - Move forward, back by full words M-f, M-b  
   - Move down, up by paragraph with C-{, C-}  
   - Search forward, back with C-s, C-r  
     Add this to .emacs to leave the cursor where the matched string starts instead of ends:  
  
         (add-hook 'isearch-mode-end-hook  
         (lambda () (when isearch-forward (goto-char isearch-other-end))))  
  
     From the comments here: https://endlessparentheses.com/leave-the-cursor-at-start-of-match-after-isearch.html  
   - Highlight with C-space, then move around  
   - Copy highlight with M-w, paste with C-y  
  
## 2023-05-03  
### (emacs, org-mode experiment ends for publishing these notes)  
  Reason for switching away from org-mode: Getting the html export styling that  
  I want requires too much markup in my text notes. I'm the primary user of the  
  notes and want to be able to cat and grep them without a bunch of markup  
  confusing the text content. Using markdown and pandoc instead.  
  
### (emacs key bindings)  
  Prefix bindings with C-c  
  
  > Sequences consisting of C-c and a letter ... are the only sequences reserved for users  
  https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Conventions.html  
  
  Use global-set-key in `~/.emacs`:  
  https://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Commands.html  
  
  
### (emacs org-mode version, org version)  
  `M-: (org-version)`  
  or  
  `M-x org-version`  
  
  I'm using 9.5.5 on emacs-plus@28  
  
### (emacs undo, redo, tree, visualization, undo tree)  
  With evil disabled I rely on the undo-tree package, which is incredible.  
  I'm using undo-tree's less ergonomic mapping, because something on my mac is  
  intercepting the more ergonomic mapping of `C-/` in Term.  
  
|   In Aquamacs:  
|     undo: `C-/`  
|     redo: `C-?`  
|  
|   In emacsplus:  
|     undo: `C-_`  
|     redo: `M-_`  
|  
|   Visualize and navigate history: `C-x u`  
  
  
### (emacs cheat sheet)  
  https://www.utm.edu/staff/jguerin/resources/utilities/emacs.html  
  
### (emacs eval)  
   Eval on minibuffer: `M-:`  
   Eval in source: `C-x C-e`  
   Eval full buffer: `M-x eval-buffer`  
  
### (emacs redo, emacs enable redo, evil)  
  Add `(evil-set-undo-system 'undo-redo)` to `~/.emacs`  
  
### (emacs get help)  
|   See what a key command is bound to  
|     C-h k <the-key-command>  
|  
|   Get a description of a variable  
|     M-x describe-variable  
|     > start typing a variable and hit tab for options  
|     > use term's cmd-f to search through variable names  
|  
|   Open the build in tutorial  
|     C-h t  
  
### (emacs org-mode, single line code block, more ergonomic than `BEGIN_SRC`)  
  Start a line with `:`  
  
### (emacs equivalent of ctrl-p, ctrlP, vim, fuzzy search)  
  Install Ivy  
  Install Projectile  
  Add this to ~/.emacs  
  
    (require 'projectile)  
    (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)  
    (setq projectile-completion-system 'ivy)  
    (projectile-mode +1)  
  
  Open fuzzy search with C-c p f  
  Open grep with C-c p s g  
  See other usage here: https://docs.projectile.mx/projectile/usage.html#basic-usage  
  Open file without fuzzy search with C-x C-f  
  
  
## 2023-05-02  
### (emacs anatomy, log statements, emacs console messages, console log)  
  https://web.physics.utah.edu/~detar/lessons/emacs/emacs/node2.html  
  Missing from this is the messages buffer, where error messages appear  
  Open the messages buffer with `C-h e`  
  Switch back to main buffer with `C-x o`  
  If messages buffer is highlighted, close it with `C-x 0`  
  If messages buffer is not highlighted, close it with `C-x 1`  
  
### (emacs, cycle folds, fold)  
  cycle all folds: `S-TAB`  
  open/close a single fold: `TAB`  
  ^ this does not work with evil. A workaround is to create a key mapping for `'org-cycle`  
  
  
## 2023-05-01  
### (emacs, org mode, indent text, visual indentation)  
  - Select the text to move around, then `C-x C-i`, then use arrow keys  
  - To change the indentation of lists in org mode, use `M-S-ArrowKey`  
  
  
### (emacs install, macos, 2022-05-01)  
 Install aquamacs  
 Install evil https://github.com/emacs-evil/evil  
  
 Also trying this version (I use a different color background to remind my fingers not to use vim bindings):  
  
     brew tap d11frosted/emacs-plus  
     brew install emacs-plus --with-native-comp  
     emacs -nw <filename> -bg '#333388'  
  
 Also trying spacemacs by following instructions for macos here:  
 https://github.com/syl20bnr/spacemacs#prerequisites  
 Move ~/.emacs and ~/.emacs.d to backup locations before attempting this  
  
 I returned to using vanilla emacs-plus after trying spacemacs.  
 I also returned to vanilla emacs without evil.  
 Evil was interfering with org-mode folding.  
  
### (emacs save)  
  C-x C-s  
  
### (emacs cancel command)  
  C-g  
  
### (emacs switch to scratch buffer)  
  
    C-x b *scratch*  
        ^ let go of control  
  
### (emacs start org mode)  
  
  Three options:  
    1. Open a file with an `.org` extension  
    2. Open a file that contains `# -*- mode: org -*-` as the first line  
    3. Execute `M-x org-mode`  
  
### (emacs list available packages  
  M-x list-packages  
  
### (emacs list installed packages)  
  M-x list-packages  
  :: scroll to the very bottom (use the 'end' key)  
  
### (how to check if org mode is installed)  
  Look for the `org` package in the list of installed packages using method above  
  
### (emacs close popup windows)  
  q  
  
### (emacs search)  
  C-s  
  search down with C-s  
  search up with C-r  
  
### (emacs org mode export html)  
  C-c C-e h o  
  
### (emacs org-mode formatting for html, export html)  
  Relevant sections of org docs:  
  https://orgmode.org/org.html#Org-Syntax  
  https://orgmode.org/org.html#Exporting  
  https://orgmode.org/manual/HTML-specific-export-settings.html  
  
  
### (emacs, org mode preserve line breaks in text file)  
  Prepend file with:  
  `#+OPTIONS: \n:t`  
  
### (emacs, show links as plain text)  
  M-x org-toggle-link-display  
  
### (emacs, org mode, publishing, export html, tutorial)  
  
  Use this to publish a project:  
  
    (require 'ox-publish)  
    (setq org-publish-project-alist  
     '(("org-notes"  
       :base-directory "~/notes/"  
       :include ("index.txt" "certbot.txt" "emacs.txt")  
       :base-extension "dummy"  
       :publishing-directory "~/notes/publish_html/"  
       :recursive t  
       :publishing-function org-html-publish-to-html  
       :headline-levels 4  
       :auto-preamble t  
       )))  
    (org-publish "org-notes" t)  
    :: Navigate to the final parentheses on each line and C-x C-e  
    :: Or use `M-x eval-buffer` to evaluate all expressions  
  
  References:  
    https://orgmode.org/worg/org-tutorials/org-publish-html-tutorial.html  
    https://www.gnu.org/software/emacs/manual/html_node/emacs/Lisp-Eval.html  
  
### (emacs, org-mode, youtube, tutorial)  
  https://www.youtube.com/watch?v=ZMEcb2rpauU  
