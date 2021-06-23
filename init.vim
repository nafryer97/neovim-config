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

" ---------------------------------- coc.nvim ----------------------------------
"  https://github.com/neoclide/coc.nvim
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
"
set updatetime=1000
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" https://github.com/neoclide/coc-snippets
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" jscon comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" ----------------------------- local user settings ----------------------------
" ------------------------------ macbook specific ------------------------------
if has('macunix')
  call plug#begin(stdpath('data') . '/plugged')
  Plug 'https://github.com/xu-cheng/brew.vim.git'
  Plug 'https://github.com/lambdalisue/battery.vim.git'
  Plug 'https://github.com/neoclide/coc.nvim.git'
  Plug 'https://github.com/vim-airline/vim-airline.git'
  Plug 'https://github.com/vim-airline/vim-airline-themes.git'
  Plug 'https://github.com/tpope/vim-fugitive.git'
  Plug 'https://github.com/sheerun/vim-polyglot.git'
  Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
  Plug 'https://github.com/pacokwon/onedarkpaco.vim.git'
  Plug 'https://github.com/sonph/onehalf.git', { 'rtp': 'vim' }
  Plug 'https://github.com/chr4/nginx.vim.git'
  Plug 'https://github.com/dense-analysis/ale.git'
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
  let g:ale_sign_info="ℹ️"
  let g:ale_sign_warning="⚠️"
  let g:ale_sign_error="‼️"

  "function! AirlineInit()
    "if battery#is_charging() ==# 0
    "  let g:ale_lint_delay = 1000
    "  let g:ale_lint_on_enter = 0
    "endif

  "endfunction
  "autocmd User AirlineAfterInit call AirlineInit()
" ------------------------------ everything else -----------------------------
else
  call plug#begin(stdpath('data') . '/plugged')
  Plug 'https://github.com/vim-airline/vim-airline.git'
  Plug 'https://github.com/vim-airline/vim-airline-themes.git'
  Plug 'https://github.com/tpope/vim-fugitive.git'
  Plug 'https://github.com/sheerun/vim-polyglot.git'
  Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
  Plug 'https://github.com/pacokwon/onedarkpaco.vim.git'
  Plug 'https://github.com/sonph/onehalf.git', { 'rtp': 'vim' }
  Plug 'https://github.com/chr4/nginx.vim.git'
  Plug 'https://github.com/neoclide/coc.nvim.git'
  Plug 'https://github.com/dense-analysis/ale.git'
  Plug 'https://github.com/browserslist/vim-browserslist.git'
  Plug 'https://github.com/preservim/nerdtree.git', { 'on':  'NERDTreeToggle' }
  Plug 'https://github.com/lervag/vimtex.git', { 'for': 'tex' }
  call plug#end()

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
"let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
" ---------------------------------- ale/coc -----------------------------------
let g:ale_linters = { 'javascript':['jshint'] }
let g:ale_disable_lsp = 0
let g:ale_echo_cursor = 1
let g:ale_cursor_detail = 0
