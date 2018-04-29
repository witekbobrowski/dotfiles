"
" PLUGINS
"

call plug#begin()
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" A light and configurable statusline/tabline plugin
Plug 'itchyny/lightline.vim'
call plug#end()

"
" SETTINGS
"

" Display line numbers of the left margin.
set number

" Display relative (to current one) line numbers on margin.
set relativenumber

" Display current line and character number on status line.
set ruler

" Always indent new line to match previous line.
set autoindent

" Enable syntax highlighting.
syntax on

" Set tab width to 4 spaces.
set tabstop=4

" Set column on 80th char lenght.
set colorcolumn=80

" Stop vim from wrapping long lines.
set nowrap

" Hide --INSERT-- from status line.
set noshowmode
