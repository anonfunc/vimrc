" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime

" Some changes from:
" http://nvie.com/posts/how-i-boosted-my-vim/
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" {{{ Basics
set nocompatible               " be iMproved
" filetype off                   " required!
" }}}
" {{{ Bundles
set rtp+=~/.vim/bundle/neobundle.vim
call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
"
let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
        let g:make = 'make'
endif
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': g:make}}

" NeoBundle time!
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-speeddating'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'tacahiroy/ctrlp-funky'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'spolu/dwm.vim'
NeoBundle 'Lokaltog/vim-easymotion'
"NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'bling/vim-airline'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'mitsuhiko/vim-jinja'
NeoBundle 'michaeljsmith/vim-indent-object'
NeoBundle "mattn/emmet-vim"
if version >= 703
    " Behave badly under 7.0.0
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'scrooloose/syntastic'
    "NeoBundle 'Shougo/neocomplcache'
    NeoBundle 'majutsushi/tagbar'
    "NeoBundle 'klen/python-mode'
    NeoBundle 'davidhalter/jedi-vim'
    NeoBundle 'hynek/vim-python-pep8-indent'
    NeoBundle 'ervandew/supertab'
    NeoBundle 'kshenoy/vim-signature'
endif
" }}}
" {{{ Turn syntax back on
syntax on
filetype plugin indent on
" }}}
NeoBundleCheck
" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  NeoBundleInstall
endif

" {{{ Appearance
if $SCHEME == 'light'
    set background=light
else
    set background=dark
endif
" set background=dark
" set background=light
" let g:solarized_termcolors=256
" set t_Co=16
set t_Co=256
let g:solarized_termtrans = 1
colorscheme solarized
hi EasyMotionShade ctermfg=black

" let g:Powerline_symbols = 'fancy'
let g:airline_powerline_fonts = 1
set laststatus=2

highlight clear SignColumn
" }}}
" {{{ Basic Vim settings
" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set nowrap
set backspace=indent,eol,start
set copyindent
set autoindent
set shiftround
set shiftwidth=2
set smarttab
set tabstop=2
set softtabstop=2
set expandtab
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set ignorecase          " Do case insensitive matching
set smartcase           " Do smart case matching
set incsearch           " Incremental search
set autowrite           " Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a             " Enable mouse usage (all modes) in terminals

set history=1000
set undolevels=1000
set title
set visualbell
set noerrorbells
set number

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
    nnoremap <silent> <leader><SPACE>n :NERDTreeFind<cr>
    nnoremap <silent> <leader><SPACE>t :TagbarToggle<cr>
    nnoremap <silent> <leader>t :TagbarToggle<cr>
endif
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader><SPACE>gs :Gstatus<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader><SPACE>gb :Gblame<cr>
nnoremap <leader>r :redraw!<cr>
nnoremap <leader><SPACE>r :redraw!<cr>

nnoremap <SPACE> :
nnoremap <SPACE><SPACE> :!

nnoremap ZX :q!<cr>

" From learn vimscript the hard way
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

nnoremap <leader>a :Ack<space>
nnoremap <leader><SPACE>a :Ack<space>

" trick from
" http://stackoverflow.com/questions/95072/what-are-your-favorite-vim-tricks
cmap w!! %!sudo tee > /dev/null %
" }}}
" {{{ Other configuation
" {{{ Fugitive
set statusline+=%{fugitive#statusline()}
" }}}
" {{{ Python
" Python - Syntastic
" Prefer flake8 only

let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_post_args='--ignore=E302,E111,E121'

" Show trailing whitepace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$/ containedin=ALL

augroup python
  autocmd!

  autocmd FileType python set cinwords=if,elif,else,for,while,try,except,finally,def,class
  autocmd FileType python set tabstop=8 shiftwidth=2 smarttab expandtab softtabstop=2 autoindent nosmartindent

  let python_space_errors = 1
  setlocal nospell
  set foldmethod=indent
  set foldlevel=99
augroup END
" }}}
" {{{ CtrlP tweaks
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.swp,*.bak,*.pyc,*.class,build,.git,.svn,*.swc,ui

let g:ctrlp_extensions = ['funky', 'mixed']
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_regexp = 1
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_default_input = 1

" Multiple VCS's:
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git', 'cd %s && git ls-files -oc --exclude-standard'],
        \ 2: ['.hg', 'hg --cwd %s locate -I .'],
    \ },
    \ 'fallback': 'find %s -type f',
    \ 'ignore': 1
    \ }


nnoremap <Leader>f :CtrlPFunky<Cr>
nnoremap <Leader><space>f :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>F :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
nnoremap <Leader><space>F :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
" }}}

" Mute ultisnips complaints about python
let g:UltiSnipsNoPythonWarning = 1

" From http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre *.{properties,xml,java} :%s/\s\+$//e
autocmd BufRead *.{xml,java} set makeprg=ant\ -emacs
" autocmd BufRead *.{xml,java} set efm=%A\ %#[javac]\ %f:%l:\ %m,%-Z\ %#[javac]\ %p^,%-C%.%#

au BufNewFile,BufRead *.gradle setf groovy

" From
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/
au FocusLost * :wa

" Use silver searcher
set grepprg=ag
let g:ackprg = 'ag --nogroup --nocolor --column'

" NerdTree tweaks
" open a NERDTree automatically when vim starts up if no files were specified
if version >= 703
    autocmd vimenter * if !argc() | NERDTree | only | endif
endif


" Persistent undo
if version >= 703
    set undofile
endif

" NeoComplCache
let g:neocomplcache_enable_at_startup = 1
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Auto chmod scripts
" From http://vim.wikia.com/wiki/Simple_creation_of_scripts
function! MySetExecutableIfScript(line1, current_file)
  if a:line1 =~ '^#!\(/usr\)*/bin/'
    let chmod_command = "silent !chmod ugo+x " . a:current_file
    execute chmod_command
  endif
endfunction
autocmd BufWritePost * call MySetExecutableIfScript(getline(1), expand("%:p"))

" }}}
" vim: fdm=marker:
