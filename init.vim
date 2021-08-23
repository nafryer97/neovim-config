" vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ----------------------------- local user settings ----------------------------
" ------------------------------ macbook specific ------------------------------
if has('macunix')
  call plug#begin(stdpath('data') . '/plugged')
  Plug 'https://github.com/neovim/nvim-lspconfig.git'
  Plug 'https://github.com/hrsh7th/nvim-compe.git'
  Plug 'https://github.com/nvim-treesitter/nvim-treesitter.git', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
  Plug 'https://github.com/xu-cheng/brew.vim.git'
  Plug 'https://github.com/lambdalisue/battery.vim.git'
  Plug 'https://github.com/vim-airline/vim-airline.git'
  Plug 'https://github.com/vim-airline/vim-airline-themes.git'
  Plug 'https://github.com/tpope/vim-fugitive.git'
  Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
  Plug 'https://github.com/skywind3000/gutentags_plus.git'
  Plug 'https://github.com/pacokwon/onedarkpaco.vim.git'
  Plug 'https://github.com/chr4/nginx.vim.git'
  Plug 'https://github.com/sonph/onehalf.git', { 'rtp': 'vim' }
  Plug 'https://github.com/browserslist/vim-browserslist.git'
  Plug 'https://github.com/preservim/nerdtree.git', { 'on':  'NERDTreeToggle' }
  Plug 'https://github.com/lervag/vimtex.git', { 'for': 'tex' }
  call plug#end()
  " --------------------------------- battery ----------------------------------
  let g:battery_watch_on_startup = 1
  let g:battery#update_interval=180000
  let g:battery#symbol_charging="🔌"
  let g:battery#symbol_discharging="🔋"
  let g:battery#component_format = " %s %v%% "
  " ------------------------------- airline/ale --------------------------------
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#battery#enabled = 1
  let g:battery#update_statusline = 1
  "let airline#extensions#ale#warning_symbol = "🟨"
  "let airline#extensions#ale#error_symbol = "🛑"

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
  "let g:ale_sign_info="ℹ️"
  "let g:ale_sign_warning="⚠️"
  "let g:ale_sign_error="‼️"

" ------------------------------ everything else -----------------------------
else

call plug#begin(stdpath('data') . '/plugged')
  Plug 'https://github.com/neovim/nvim-lspconfig.git'
  Plug 'https://github.com/hrsh7th/nvim-compe.git'
  Plug 'https://github.com/nvim-treesitter/nvim-treesitter.git', { 'branch': '0.5-compat', 'do': ':TSUpdate' }
  Plug 'https://github.com/vim-airline/vim-airline.git'
  Plug 'https://github.com/vim-airline/vim-airline-themes.git'
  Plug 'https://github.com/tpope/vim-fugitive.git'
  Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
  Plug 'https://github.com/skywind3000/gutentags_plus.git'
  Plug 'https://github.com/pacokwon/onedarkpaco.vim.git'
  Plug 'https://github.com/sonph/onehalf.git', { 'rtp': 'vim' }
  Plug 'https://github.com/chr4/nginx.vim.git'
  Plug 'https://github.com/browserslist/vim-browserslist.git'
  Plug 'https://github.com/preservim/nerdtree.git', { 'on':  'NERDTreeToggle' }
  call plug#end()
endif

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

set tabstop=4
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

if $TERM==# 'alacritty'
    set termguicolors
endif

" json comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

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
let g:airline#extensions#ale#enabled = 1
"let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" ---------------------------------- ale/coc -----------------------------------
"let g:ale_linters = { 'javascript':['jshint'] }
"let g:ale_disable_lsp = 1
"let g:ale_echo_cursor = 1
"let g:ale_cursor_detail = 0
"let g:ale_sign_column_always = 1

" --------------------------------- gutentags ----------------------------------
let g:gutentags_define_advanced_commands = 1
let g:gutentags_add_default_project_roots = 1
let g:gutentags_trace = 0
" enable gtags module
let g:gutentags_modules = ['ctags', 'gtags_cscope']

" config project root markers.
let g:gutentags_project_root = ['.root']

" generate datebases in my cache directory, prevent gtags files polluting my project
let g:gutentags_cache_dir = expand('~/.cache/tags')

" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

" -------------------------------- nvim-lspconfig ------------------------------
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd', 'cmake', 'vimls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#customizing-how-diagnostics-are-displayed
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

-- https://github.com/hrsh7th/nvim-compe/#lua-config
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    luasnip = true;
    spell = true;
    tags = true;
    treesitter = true;
  };
}

-- https://www.chrisatmachine.com/Neovim/27-native-lsp/
  local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
local col = vim.fn.col('.') - 1
if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
else
    return false
end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
elseif check_back_space() then
    return t "<Tab>"
else
    return vim.fn['compe#complete']()
end
end

_G.s_tab_complete = function()
if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
  indent = {
  enable = true,
  }
}
EOF

" https://github.com/hrsh7th/nvim-compe/#mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

" auto-format
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
highlight link CompeDocumentation NormalFloat
