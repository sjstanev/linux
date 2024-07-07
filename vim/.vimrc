set nocompatible
syntax on
filetype on
filetype plugin on
filetype indent on

" show you where your search will match
:set incsearch

" search highlighting
:set hlsearch

" Case (in)sensitivity
" Normally Vim searches are case-sensitive. If you would prefer case insensitive set the following option:
:set ignorecase

" Better still, if you'd like \"partial sensitivity\", set this option as well:
:set smartcase

" Note that the highlighting persists until your next search. To get rid of it, type:
" :nohlsearch or If this is still tedious, so maybe( in your .vimrc )
nmap <silent>  <BS>  :nohlsearch<CR>

