" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime

" Some changes from:
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundle time!
Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'altercation/vim-colors-solarized'
Bundle 'spolu/dwm.vim'

syntax on
filetype plugin indent on

" Appearance
" set background=dark
" set background=light
" let g:solarized_termcolors=256
colorscheme solarized

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


" JK in insert is <esc>
inoremap jk <ESC>

" Show whitespace mode.
"set list
"set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Custom commands
nnoremap <silent> <leader>\ :nohlsearch<cr>
nnoremap <silent> <leader>n :NERDTreeFind<cr>
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

" Fugitive
set statusline+=%{fugitive#statusline()}

" From http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre *.{properties,xml,java} :%s/\s\+$//e


autocmd BufRead *.{xml,java} set makeprg=ant\ -emacs
" autocmd BufRead *.{xml,java} set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

" Better expansion
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.swp,*.bak,*.pyc,*.class,build,.git,.svn,*.swc,ui

" Use ack
set grepprg=ack

" NerdTree tweaks
" open a NERDTree automatically when vim starts up if no files were specified
autocmd vimenter * if !argc() | NERDTree | endif

