" ------ basics ------
cnoreabbrev W w
set clipboard=unnamed,unnamedplus
nmap <silent> <leader>m :set invnumber<CR>
set hidden
syntax enable
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
"  ----- plugins ------
call vundle#begin()
Plugin '907th/vim-auto-save'
call vundle#end()

filetype plugin indent on
call plug#begin('~/.vim/plugged')
Plug 'rafi/awesome-vim-colorschemes'
" Plug 'ziglang/zig.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'timonv/vim-cargo'
Plug 'jbyuki/venn.nvim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
  Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-startify'
call plug#end()


" ------ NERDTree ------
set nonumber
set t_Co=256   " This is may or may not needed.
set laststatus=2
" let g:solarized_termcolors=256  
" set background=dark
let g:seoul256_background = 237

" jellyx, herald, jelleybeans, seoul256
colo PaperColor
set background=dark
" :nmap <Tab> :NERDTreeToggle<CR>
:set modifiable

function! IsNerdTreeEnabled()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

noremap <silent> <leader>t :NERDTreeToggle<CR>
noremap <silent> <leader>f :NERDTreeFocus<CR>

" let g:NERDTreeMinimalMenu=1

let g:NERDCreateDefaultMappings = 1

" nnoremap <silent> <c-_>c} V}:call NERDComment('x', 'toggle')<CR>

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if winnr() == winnr('h') && bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


" ------ Coc.nvim ------
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

noremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Applying code actions to the selected code block
" Example: `<c-a-ap` for current paragraph
xmap <c-a>  <Plug>(coc-codeaction-selected)<CR>coc#refresh()
nmap <c-a>  <Plug>(coc-codeaction-selected)<CR>coc#refresh()

" Remap keys for applying code actions at the cursor position
" nmap <c-q>  <Plug>(coc-codeaction-cursor)<CR>
" Remap keys for apply code actions affect whole buffer
" nmap <c-a-s>  <Plug>(coc-codeaction-source)<CR>
" Apply the most preferred quickfix action to fix diagnostic on the current line
" nmap <c-q> <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
" nmap <silent> <c-q> <Plug>(coc-codeaction-refactor)
" xmap <silent> <c-q>  <Plug>(coc-codeaction-refactor-selected)
" nmap <silent> <c-q>  <Plug>(coc-codeaction-refactor-selected)

nnoremap <c-j> <Plug>(coc-diagnostic-next-error)
nnoremap <c-k> <Plug>(coc-diagnostic-prev-error)


" Formatting selected code
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)


function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

nmap <silent> <s-f> :Format<CR>

" ------ papercolor airline ------
" let g:airline_theme='papercolor'

" ------ Test ------
" nmap <silent> <leader>t :TestNearest<CR>
" nmap <silent> <leader>T :TestFile<CR>
" nmap <silent> <leader>a :TestSuite<CR>
" nmap <silent> <leader>l :TestLast<CR>
" nmap <silent> <leader>g :TestVisit<CR>

" Zig
" nmap <silent> <leader>b :terminal zig build
" nmap <silent> <leader>a :terminal zig run <CR>i

" C
" nmap <silent> <leader>b :terminal gcc main.c -o main && ./main<CR>i
" nmap <silent> <leader>a :terminal cargo test -- --nocapture --test-threads=1<CR>i
" nmap <silent> <leader>c :terminal gcc main.c -o main && ./main<CR>i

" Rust
nmap <silent> <leader>b :terminal cargo bench --profile=release<CR>i
nmap <silent> <leader>a :terminal cargo test -- --nocapture --test-threads=1<CR>i
nmap <silent> <leader>d :terminal cargo run<CR>i
nmap <silent> <leader>c :terminal ./dev.sh<CR>i
nmap <silent> <leader>u :AutoSaveToggle<CR>

nmap <silent> <leader>n :NERDTreeCWD<CR>
nmap <silent> <leader>s :Startify<CR>

let g:test#rust#runner = 'cargotest'
let test#ruby#minitest#options = '--verbose'
let g:test#rust#cargotest#options = '-- --nocapture --test-threads=1'


" ------ auto save ------
let g:auto_save = 1  " enable AutoSave on Vim startup
" autocmd TextChanged,TextChangedI <buffer> silent write

