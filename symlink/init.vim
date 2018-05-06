"
" PLUGINS
"

call plug#begin()
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" A light and configurable statusline/tabline plugin
Plug 'itchyny/lightline.vim'
" Vim runtime files for Swift
Plug 'keith/swift.vim'
" Python syntax highlighting
Plug 'vim-python/python-syntax'
" Text filtering and alignment
Plug 'godlygeek/tabular'
" Markdown Vim Mode
Plug 'plasticboy/vim-markdown'
" Instant Markdown previews from VIm!
Plug 'suan/vim-instant-markdown'
call plug#end()

"
" GENERAL SETTINGS
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
set wrap
" Hide --INSERT-- from status line.
set noshowmode
" Disable folding of long files.
set nofoldenable

"
" PLUGIN CONFIGS
"

" suan/vim-instant-markdown
"
" Disable instant refresh
let g:instant_markdown_slow = 1
