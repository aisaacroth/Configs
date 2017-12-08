set nocompatible " required file
filetype off     " required

" Set the runtime path to include Vundle and intialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim'}
Plugin 'elmcast/elm-vim'

set laststatus=2

" All of Plugins must be added before the following line
call vundle#end()         " required
filetype plugin indent on " required


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

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
filetype on
filetype plugin on
filetype indent on
 
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


set autoindent                " always set autoindenting on

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
 
" When coding, auto-indent by 4 spaces, just like in K & R
" Note that this does NOT change tab into 4 spaces
" You can do that with "set tabstop=4", which is a BAD idea
set shiftwidth=4

set expandtab
"Always replace tab with 8 spaces, except for makefiles
autocmd FileType make setlocal noexpandtab
autocmd FileType html* setlocal ts=2 sw=2 expandtab
 
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

" YAML
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Highlight anything over 80 characters long
" match Error /\%81v.\+/

" Set a line at 80 characters
set colorcolumn=80
set cursorline
colorscheme molokai
set scrolloff=5

" Map to visual lines instead of actual lines.
:nnoremap <buffer> <silent> k gk
:nnoremap <buffer> <silent> j gj
:nnoremap <buffer> <silent> 0 g0
:nnoremap <buffer> <silent> $ g$

" Map to switch windows
:nnoremap <C-J> <C-W><C-J>
:nnoremap <C-K> <C-W><C-K>
:nnoremap <C-L> <C-W><C-L>
:nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
:nnoremap <space> za

" See docstrings for folded code
let g:SimplyFold_docstring_preview=1

" Set UTF8 Support
set encoding=utf-8

" Show errors in list
let g:syntastic_always_populate_loc_list = 1

" Autofill the location list
let g:syntastic_auto_loc_list = 1

" Run syntastic on opening file
let g:syntastic_check_on_open = 0

" Run syntastic on write to file
let g:syntastic_check_on_wq = 1

" Turn on elm errors
let g:elm_syntastic_show_warnings = 1

" Python syntax highlighting
let python_highlight_all = 1
syntax on

" Set mapleader
let mapleader = "-"

" Set maplocalleader
let maplocalleader = "_"

" Convert current word to uppercase in insert mode
inoremap <leader><c-u> <esc>veU<esc>i

" Convert current word to uppercase in normal mode
nnoremap <leader><c-u> veU

" Edit ~/.vimrc on the fly
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Source ~/.vimrc on the fly
nnoremap <leader>sv :source $MYVIMRC<cr>

" Abbreviation for my work email
iabbrev @@ aroth@dia.co

" Wrap word in double quotation marks
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" Wrap word in single quotation marks
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

" Jump to beginning of current line
nnoremap H 0

" Jump to the end of the current line
nnoremap L $

" Remap esc to jk
inoremap jk <esc>

" Wrap word in parentheses
nnoremap <leader>p viw<esc>a)<esc>hbi(<esc>lel

