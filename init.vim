" Neovim configuations 31 March 2021
" these can be global system settings. local user settings are noted below

syntax enable
filetype plugin indent on

" easy switching between buffers
set hidden

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline
set smartcase
set ruler
set lazyredraw
set cmdheight=2
set shiftwidth=4
set softtabstop=4
set expandtab
set autoread
set breakindent
set colorcolumn=81
hi ColorColumn ctermbg=lightgrey guibg=lightgrey
set textwidth=80
set showmatch
set wildmode=longest,list
set splitbelow
set splitright
set scrolloff=2
set spell spelllang=en_us
set number
map Y y$
nnoremap <C-L> :nohl<CR><C-L>

" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if $TERM==# 'alacritty'
    set termguicolors
endif

" ----------------------------- local user settings ----------------------------
" ------------------------------ macbook specific ------------------------------
if has('macunix')
  call plug#begin(stdpath('data') . '/plugged')
  Plug 'https://github.com/xu-cheng/brew.vim.git'
  Plug 'https://github.com/lambdalisue/battery.vim.git'
  Plug 'https://github.com/neovim/nvim-lspconfig.git'
  Plug 'https://github.com/vim-airline/vim-airline.git'
  Plug 'https://github.com/vim-airline/vim-airline-themes.git'
  Plug 'https://github.com/tpope/vim-fugitive.git'
  Plug 'https://github.com/sheerun/vim-polyglot.git'
  Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
  Plug 'https://github.com/pacokwon/onedarkpaco.vim.git'
  Plug 'https://github.com/sonph/onehalf.git'
  Plug 'https://github.com/chr4/nginx.vim.git'
  Plug 'https://github.com/dense-analysis/ale.git'
  Plug 'https://github.com/preservim/nerdtree.git', { 'on':  'NERDTreeToggle' }
  Plug 'https://github.com/lervag/vimtex.git', { 'for': 'tex' }
  call plug#end()
  " --------------------------------- battery ----------------------------------
  let g:battery_watch_on_startup = 1
  let g:battery#update_interval=180000
  let g:battery#symbol_charging="🔌"
  let g:battery#symbol_discharging="🔋"
  let g:battery#component_format = " %s %v%% "
  " --------------------------------- airline ----------------------------------
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#battery#enabled = 1
  let g:battery#update_statusline = 1
  let airline#extensions#ale#warning_symbol = "🟨"
  let airline#extensions#ale#error_symbol = "🛑"

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
    let g:airline_symbols.crypt = "🔐"
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly="🔒"
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.dirty='🪲'
  endif
  " --------------------------------- ale ----------------------------------
  let g:ale_sign_info="💬"
  let g:ale_sign_warning="🟨"
  let g:ale_sign_error="🛑"

  function! AirlineInit()
    if battery#is_charging() ==# 0
      let g:ale_lint_delay = 1000
      let g:ale_lint_on_enter = 0
    endif

    if airline#util#winwidth() > 99
      let g:airline_section_a = airline#section#create_left(['mode','paste','spell','filetype','capslock','battery'])
    else
      let g:airline_section_a = airline#section#create_left(['mode','capslock'])
    endif
    
    let g:airline_section_b = airline#section#create(['hunks', 'branch'])

    if exists("+autochdir") && &autochdir == 1
      let g:airline_section_c = airline#section#create(['📂','path','readonly'])
    else
      let g:airline_section_c = airline#section#create(['📄','file','readonly'])
    endif

    let g:airline_section_gutter = airline#section#create(['%='])

    if airline#util#winwidth() > 79
      let g:airline_section_x = airline#section#create_right(['gutentags'])
    endif
    let g:airline_section_y = airline#section#create_right([])
    let g:airline_section_z = airline#section#create(['whitespace'])
    let g:airline_section_error = airline#section#create(['ale_error_count'])
    let g:airline_section_warning = airline#section#create(['ale_warning_count'])
  endfunction
  autocmd User AirlineAfterInit call AirlineInit()
" ------------------------------ everything else -----------------------------
else
  call plug#begin(stdpath('data') . '/plugged')
  Plug 'https://github.com/neovim/nvim-lspconfig.git'
  Plug 'https://github.com/vim-airline/vim-airline.git'
  Plug 'https://github.com/vim-airline/vim-airline-themes.git'
  Plug 'https://github.com/tpope/vim-fugitive.git'
  Plug 'https://github.com/sheerun/vim-polyglot.git'
  Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
  Plug 'https://github.com/pacokwon/onedarkpaco.vim.git'
  Plug 'https://github.com/sonph/onehalf.git'
  Plug 'https://github.com/chr4/nginx.vim.git'
  Plug 'https://github.com/dense-analysis/ale.git'
  Plug 'https://github.com/preservim/nerdtree.git', { 'on':  'NERDTreeToggle' }
  Plug 'https://github.com/lervag/vimtex.git', { 'for': 'tex' }
  call plug#end()

function! AirlineInit()
  let g:airline_section_b = airline#section#create(["hunks","branch"])
  let g:airline_section_warning = airline#section#create_left(["ale_warning_count"])
  let g:airline_section_error = airline#section#create(["ale_error_count"])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
endif
" --------------------------------- colorscheme --------------------------------
colorscheme onedarkpaco
" ---------------------------------- NERDTree ----------------------------------
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
      \ quit | endif
" ---------------------------------- airline -----------------------------------
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline_theme="onedark"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" ------------------------------------ ale -------------------------------------
let g:ale_lsp_suggestions = 1
let g:ale_lsp_show_message_severity = "information"
let g:ale_set_quickfix = 1
let g:ale_virtualtext_cursor = 1
