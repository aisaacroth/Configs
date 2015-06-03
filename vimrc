if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup          " do not keep a backup file, use versions instead
else
  set backup            " keep a backup file
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")
" Don't use Ex mode, use Q for formatting
map Q gq
 
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
 inoremap <C-U> <C-G>u<C-U>
 
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
 
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent                " always set autoindenting on
     
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

" Line numbers
set number
 
" Buffer switching using Cmd-arrows in Mac and Alt-arrows in Linux
:nnoremap <D-Right> :bnext<CR>
:nnoremap <M-Right> :bnext<CR>
:nnoremap <D-Left> :bprevious<CR>
:nnoremap <M-Left> :bprevious<CR>
"" and don't let MacVim remap them
if has("gui_macvim")
        let macvim_skip_cmd_opt_movement = 1
endif
 
" When coding, auto-ident by 4 spaces, just like in K & R
" Note that this does NOT change tab into 4 spaces
" You can do that with "set tabstop=4", which is a BAD idea
set shiftwidth=4

"Always replace tab with 8 spaces, except for makefiles
set expandtab
autocmd FileType make setlocal noexpandtab
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" My settings when editing *.txt files
" - automatically indent lines according to previous lines
" - replace tab with 8 spaces
" - when I hit tab key, move 2 spaces instead of 8
" - wrap text if I go longer than 76 columns
" - check spelling
autocmd FileType text setlocal autoindent expandtab softabstop=2 textwidth=76 spell spelllang=en_us
 
" Don't do spell-checking on Vim help files.
autocmd FileType help setlocal nospell
 
" Prepend ~/.backup to backupdir so that Vim will look for that directory
" before littering the current dir with backups
" You need to do "mkdir ~/.backup" for this to work.
set backupdir^=~/.backup
 
" Also use ~/.backup for swap files. The trailing // tells Vim to incorporate
" full path into swap file names.
set dir^=~/.backup//
 
" Ignore case when searching
" - override this setting by tacking on \c or \C to your search term to make
"   your search always case-insensitive or case-sensitive, respectively.
set ignorecase

" Markdown
au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.md setf markdown

execute pathogen#infect()
 
match Error /\%81v.\+/
set cursorline
colorscheme molokai
set scrolloff=5

"" Map to visual lines instead of actual lines.
:nnoremap <buffer> <silent> k gk
:nnoremap <buffer> <silent> j gj
:nnoremap <buffer> <silent> 0 g0
:nnoremap <buffer> <silent> $ g$