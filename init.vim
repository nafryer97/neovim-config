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

" local user settings

" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" Declare the list of plugins.
Plug 'https://github.com/neomake/neomake'
Plug 'https://github.com/preservim/nerdtree.git', { 'on':  'NERDTreeToggle' }
Plug 'https://github.com/vim-airline/vim-airline.git'
Plug 'https://github.com/vim-airline/vim-airline-themes.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/sheerun/vim-polyglot.git'
Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
Plug 'https://github.com/lambdalisue/battery.vim.git'
Plug 'https://github.com/pacokwon/onedarkpaco.vim.git'
Plug 'https://github.com/sonph/onehalf.git'
Plug 'https://github.com/chr4/nginx.vim.git'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" --------------------------------- colorscheme --------------------------------
colorscheme onedarkpaco

" ---------------------------------- NERDTree ----------------------------------
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" ---------------------------------- airline -----------------------------------
if has('macunix')
    let g:airline#extensions#battery#enabled = 1
    let g:battery#update_statusline = 1
endif
let g:airline_theme='night_owl'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'short_path'
let g:airline_stl_path_style = 'short'
let g:airline_skip_empty_sections = 1
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
let g:airline_section_z = airline#section#create([''])
let g:airline_section_error = airline#section#create(['neomake_error_count'])
let g:airline_section_warning = airline#section#create(['neomake_warning_count'])

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'

" ---------------------------------- neomake -----------------------------------
function MyOnBattery()
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
endfunction

if has('macunix')
    if MyOnBattery()
        call neomake#configure#automake('w')
    else
        call neomake#configure#automake('nw', 1000)
    endif
else
    call neomake#configure#automake('w')
endif
