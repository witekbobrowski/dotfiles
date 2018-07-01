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
" Enchanced jupyter notebook edition
Plug 'szymonmaszke/vimpyter'
" Smooth jumping
Plug 'yuttie/comfortable-motion.vim'
" Parenthisis highlighting enhanced
Plug 'eapache/rainbow_parentheses.vim'
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
" Stop vim from wrapping long lines.
set wrap
" Hide --INSERT-- from status line.
set noshowmode
" Disable folding of long files.
" set nofoldenable
" Shared clipboard between vim and os
set clipboard=unnamedplus
"
" MAPPING
"

let g:mapleader = "\<Space>"
nnoremap Z za
nnoremap z zA
nnoremap <silent><Leader>z :let &foldlevel = &foldlevel==0 ? &foldnestmax : 0<CR>
autocmd Filetype ipynb nnoremap <silent><tab>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nnoremap <silent><tab>j :VimpyterStartJupyter<CR>

let g:vimpyter_color = 1

"
" PLUGIN CONFIGS
"

" suan/vim-instant-markdown {{{
"
" Disable instant refresh
let g:instant_markdown_slow = 1

" }}}

" eapache/rainbow_parentheses.vim {{{

let g:rbpt_colorpairs = [
      \ ['red',         'RoyalBlue3'],
      \ ['brown',       'SeaGreen3'],
      \ ['blue',        'DarkOrchid3'],
      \ ['gray',        'firebrick3'],
      \ ['green',       'RoyalBlue3'],
      \ ['magenta',     'SeaGreen3'],
      \ ['cyan',        'DarkOrchid3'],
      \ ['darkred',     'firebrick3'],
      \ ['brown',       'RoyalBlue3'],
      \ ['darkblue',    'DarkOrchid3'],
      \ ['gray',        'firebrick3'],
      \ ['darkgreen',   'RoyalBlue3'],
      \ ['darkmagenta', 'SeaGreen3'],
      \ ['darkcyan',    'DarkOrchid3'],
      \ ['red',         'firebrick3'],
      \ ]
let g:rbpt_max = 15
let g:rbpt_loadcmd_toggle = 0
let g:bold_parentheses = 1
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['<','\>'], ['{', '}']]

augroup AutoStartParentheses
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
augroup END
" }}}
