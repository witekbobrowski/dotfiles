scriptencoding utf8

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
" Linter warnings in statusline
Plug 'maximbaz/lightline-ale'
" Text filtering and alignment
Plug 'godlygeek/tabular'
" Smooth jumping
Plug 'yuttie/comfortable-motion.vim'
" The fancy start screen for Vim.
Plug 'mhinz/vim-startify'
" Comment stuff out
Plug 'tpope/vim-commentary'
" Git diff in the gutter 
Plug 'airblade/vim-gitgutter'
" True Sublime Text style multiple selections
Plug 'terryma/vim-multiple-cursors'
" The Neosnippet plug-In adds snippet support to Vim
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
" Makes vim interrupt you less
Plug 'vim-utils/vim-interruptless'
" Run your tests at the speed of thought
Plug 'janko-m/vim-test'
" fzf + vim
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
" Display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'

"
" Colorschemes
"

Plug 'AlessandroYorba/Sierra'


"
" Swift
"
" Vim plugin for generating docstrings in Swift sources
Plug '~/Developer/personal/vim-swiftdocstring'
" Vim runtime files for Swift
Plug 'keith/swift.vim'
" Swift code complition
Plug 'mitsuse/autocomplete-swift'
" Work with Xcode projects from within Vim
Plug 'gfontenot/vim-xcode'

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
" Markdown preview plugin for neovim
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
"

" JavaScript 
"
" React JSX syntax highlighting and indenting
Plug 'pangloss/vim-javascript'

call plug#end()

"
" GENERAL SETTINGS
"

" Set colorscheme 
colorscheme sierra
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
let &colorcolumn='80,'.join(range(120,999),',')
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

"
" MAPPING
"

let g:mapleader = "\<Space>"
nnoremap Z za
nnoremap z zA
nnoremap <silent><Leader>z :let &foldlevel = &foldlevel==0 ? &foldnestmax : 0<CR>


"
" PLUGIN CONFIGS
"
"

" szymonmaszke/vimpyter {{{
"
"
let g:vimpyter_color = 1
autocmd Filetype ipynb nnoremap <silent><tab>b :VimpyterInsertPythonBlock<CR>
autocmd Filetype ipynb nnoremap <silent><tab>j :VimpyterStartJupyter<CR>

" }}}

" Shougo/deoplete.nvim {{{
"
" Path to python
let g:python3_host_prog = '/usr/local/opt/python/bin/python3.7'
" Use deoplete.
let g:deoplete#enable_at_startup = 1

" }}}

" Shougo/neosnippet.vim {{{
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" }}}

" witekbobrowski/vim-swiftdocstring {{{
"
" Generate docstring for current context
autocmd Filetype swift nnoremap <silent><tab>/ :SwiftDocstringCurrent<CR>
" }}}


" landaire/deoplete-swift {{{
"
" Path to SourceKitten binary 
let g:deoplete#sources#swift#source_kitten_binary = '/usr/local/bin/sourcekitten'
" Jump to the first placeholder by typing `<C-k>`.
autocmd FileType swift imap <buffer> <C-k> <Plug>(autocomplete_swift_jump_to_placeholder)
" }}}

" Plug 'gfontenot/vim-xcode' {{{
"
" 
autocmd FileType swift nmap <silent><tab>b :Xbuild<CR>
autocmd FileType swift nmap <silent><tab>r :Xrun<CR>
autocmd FileType swift nmap <silent><tab>u :Xtest<CR>
autocmd FileType swift nmap <silent><tab>c :Xclean<CR>

" }}}

" iamcco/markdown-preview.nvim {{{
"
" Preview markdown file on open
let g:mkdp_auto_start = 1
" }}}

" 'itchyny/lightline.vim' {{{
"
let g:lightline = {}
let g:lightline.mode_map = {
      \ 'n' : '',
      \ 'i' : '',
      \ 'R' : '',
      \ 'v' : '',
      \ 'V' : ' ',
      \ "\<C-v>": ' ',
      \ 'c' : ' command',
      \ 's' : ' select',
      \ 'S' : ' S-LINE',
      \ 't': '',
      \}
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename' ] ],
      \   'right': [ [ 'percent' ], ['linter_errors', 'linter_warnings', 'linter_ok']]
      \ },
      \ 'component_expand': {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ },
      \ 'component_type': {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'readonly': 'LightlineReadonly',
      \   'modified': 'LightlineModified',
      \   'filename': 'LightlineFilename',
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }
" }}}

" maximbaz/lightline-ale {{{
"
let g:lightline#ale#indicator_warnings = ''
let g:lightline#ale#indicator_errors = ''
let g:lightline#ale#indicator_ok = ''
" }}}

" airblade/vim-gitgutter {{{
"
"
let g:gitgutter_terminal_reports_focus=0
let g:gitgutter_diff_base='HEAD'
let g:gitgutter_grep = 'rg' 
" }}}

" w0rp/ale {{{
"
" Enable completion where available.
" This setting must be set before ALE is loaded.
let g:ale_completion_enabled = 1
" }}}

" junegunn/fzf.vim {{{
"
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'left': '~20%' }
" }}}
