" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime

" Some changes from:
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" {{{ Basics
set nocompatible               " be iMproved
filetype off                   " required!
" }}}
" {{{ Vundles
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundle time!
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-repeat'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'spolu/dwm.vim'
Bundle 'derekwyatt/vim-scala'
if version >= 703
    " Behave badly under 7.0.0
    Bundle 'scrooloose/nerdtree'
    Bundle 'Shougo/neocomplcache'
    Bundle 'Shougo/neocomplcache-snippets-complete'
endif

" }}}
" {{{ Turn syntax back on
syntax on
filetype plugin indent on
" }}}
" {{{ Appearance
set background=dark
" set background=light
" let g:solarized_termcolors=256
colorscheme solarized
" }}}
" {{{ Basic Vim settings
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set nowrap
set backspace=indent,eol,start
set copyindent
set autoindent
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4
set softtabstop=4
set expandtab
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes) in terminals

set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells

if !&diff && version >= 703
    set relativenumber
    set gdefault
endif

" set wrap
" set textwidth=79
" set formatoptions=qrn1
" set colorcolumn=85

set nobackup
set noswapfile
" }}}
" {{{ Custom bindings
" JK in insert is <esc>
inoremap jk <ESC>

" Show whitespace mode.
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Custom commands
nnoremap <silent> <leader>\ :nohlsearch<cr>
if version >= 703
    nnoremap <silent> <leader>n :NERDTreeFind<cr>
endif
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>

nnoremap <SPACE> :
nnoremap <SPACE><SPACE> :!

nnoremap ZX :q!<cr>

" From learn vimscript the hard way
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" trick from
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks 
cmap w!! %!sudo tee > /dev/null %
" }}}
" {{{ Other configuation
" {{{ Fugitive
set statusline+=%{fugitive#statusline()}
" }}}
" {{{ CtrlP tweaks
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.swp,*.bak,*.pyc,*.class,build,.git,.svn,*.swc,ui

let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

" Multiple VCS's:
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'git --git-dir=%s/.git ls-files -oc --exclude-standard'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'find %s -type f',
    \ 'ignore': 1
    \ }
" }}}

" From http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre *.{properties,xml,java} :%s/\s\+$//e
autocmd BufRead *.{xml,java} set makeprg=ant\ -emacs
" autocmd BufRead *.{xml,java} set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#


" Use ack
set grepprg=ack

" NerdTree tweaks
" open a NERDTree automatically when vim starts up if no files were specified
if version >= 703
    autocmd vimenter * if !argc() | NERDTree | endif
endif

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"
" }}}
" vim: fdm=marker:
