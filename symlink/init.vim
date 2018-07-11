"
" PLUGINS
"

call plug#begin()
" Asynchronous Lint Engine
Plug 'w0rp/ale'
" Asynchronous completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" A light and configurable statusline/tabline plugin
Plug 'itchyny/lightline.vim'
" Text filtering and alignment
Plug 'godlygeek/tabular'
" Smooth jumping
Plug 'yuttie/comfortable-motion.vim'
" Parenthisis highlighting enhanced
" Plug 'eapache/rainbow_parentheses.vim'

"
" Swift
"
" Vim runtime files for Swift
Plug 'keith/swift.vim'
" Swift code complition
Plug 'landaire/deoplete-swift'
"

"
" Python
" 
" Python syntax highlighting
Plug 'vim-python/python-syntax'
"

"
" Jupyter Notebook
"
" Enchanced jupyter notebook edition
Plug 'szymonmaszke/vimpyter'
"

" Markdown
"
" Markdown Vim Mode
Plug 'plasticboy/vim-markdown'
" Instant Markdown previews from VIm!
Plug 'suan/vim-instant-markdown'
"

call plug#end()

"
" GENERAL SETTINGS
"

" Set font to Apple San Francisco Mono spaced
set guifont=SF-Mono-Regular\ 14
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
" Reindent width
set shiftwidth=4
" Tab width
set softtabstop=4
" Expands tab to spaces
set expandtab
" Set tab width to 4 spaces.
set tabstop=4
" Set column on 80th char lenght.
set colorcolumn=80
" Color column 80th and from 120 to 900 (warning/danger zone)
let &colorcolumn="80,".join(range(120,999),",")
" Set color for columns above 
highlight ColorColumn ctermbg=235 guibg=#2c2d27
" Highlight current line
set cursorline
" Set color for current line highlighting
highlight CursorLine cterm=NONE ctermbg=235 guibg=#2c2d27 
" Stop vim from wrapping long lines.
set wrap
" Hide --INSERT-- from status line.
set noshowmode
" Disable folding of long files.
" set nofoldenable
" Shared clipboard between vim and os
set clipboard=unnamedplus
" Keep at least 3 lines left/right
set sidescrolloff=3
" Keep at least 3 lines above/below
set scrolloff=3
" Path to python
let g:python3_host_prog = '/usr/local/bin/neovim3/bin/python'

"
" MAPPING
"

let g:mapleader = "\<Space>"
nnoremap Z za
nnoremap z zA
nnoremap <silent><Leader>z :let &foldlevel = &foldlevel==0 ? &foldnestmax : 0<CR>
autocmd Filetype ipynb nnoremap <silent><tab>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nnoremap <silent><tab>j :VimpyterStartJupyter<CR>


"
" PLUGIN CONFIGS
"

" szymonmaszke/vimpyter {{{
"
"
let g:vimpyter_color = 1

" }}}

" Shougo/deoplete.nvim {{{
"
" Use deoplete.
let g:deoplete#enable_at_startup = 1

" }}}

" suan/vim-instant-markdown {{{
"
" Disable instant refresh
let g:instant_markdown_slow = 1

" }}}
