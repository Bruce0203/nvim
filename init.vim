" ------ basics ------
:set fillchars+=vert:\ 
set cmdheight=1
cnoreabbrev W w
cnoreabbrev Wq wq
cnoreabbrev wQ wq

cnoreabbrev qw wq
cnoreabbrev Qw wq
cnoreabbrev qW wq
cnoreabbrev QW wq
cnoreabbrev WQ wq
cnoreabbrev wQ wq

cnoreabbrev QA qa
cnoreabbrev qA qa
cnoreabbrev Qa qa

cnoreabbrev Wqa wqa
cnoreabbrev WQa wqa
cnoreabbrev WQA wqa
cnoreabbrev wQa wqa
cnoreabbrev wQA wqa
cnoreabbrev wqA wqa

set clipboard=unnamed,unnamedplus
nmap <silent> <Space>m :set invnumber<CR>
set hidden
syntax enable
set nocompatible              " be iMproved, required
set modifiable 
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim

set guioptions-=T
set signcolumn=yes
" set foldcolumn=0
" set fillchars=eob:\ 
" set colorcolumn=\ 
"  ----- plugins ------
call vundle#begin()
Plugin '907th/vim-auto-save'
call vundle#end()
filetype plugin indent on
call plug#begin('~/.vim/plugged')
" Plug 'vimpostor/vim-lumen'
Plug 'ralismark/vim-recover'
Plug 'pappasam/papercolor-theme-slim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'Mofiqul/vscode.nvim'
Plug 'jbyuki/venn.nvim'
Plug 'EVODelavega/vim-eazy-timer'
Plug 'sainnhe/gruvbox-material'
Plug 'projekt0n/github-nvim-theme'
Plug 'NLKNguyen/papercolor-theme'
call plug#end()

" ------ auto save ------
let g:auto_save = 1  " enable AutoSave on Vim startup
let g:auto_save_silent = 1  " do not display the auto-save notification

" ------ NERDTree ------
let NERDTreeChDirMode=2
let NERDTreeWinPos="left"
let g:NERDTreeWinSize=9999999
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '
" " Hide the current working directory in NERDTree
" augroup nerdtreehidecwd
"   autocmd!
"   autocmd FileType nerdtree setlocal conceallevel=3
"           \ | syntax match NERDTreeHideCWD #^[</].*$# conceal
"           \ | setlocal concealcursor=n
" augroup end

map <C-a> :NERDTreeToggle<CR>
nnoremap <Space>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let g:NERDTreeHijackNetrw=0
let g:NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI=1
let g:NERDCreateDefaultMappings = 1
let g:NERDTreeMinimalMenu=1
set nonumber
set laststatus=0
let s:hidden_all = 1
set noshowmode
set noruler
set noshowcmd
function! IsNerdTreeEnabled()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

" nnoremap \d :bp<cr>:bd #<cr>



" ------ theme ------
" set t_Co=256   " This is may or may not needed.

set bg=dark
" colo deep-space
colo github_dark_dimmed
" colo anderson
" colorscheme PaperColorSlimLight
" colo gruvbox
" colo anderson
" colo github_dark
" colo gruvbox-material
" colorscheme vscode


augroup custom_papercolorslim_transparent_background
  autocmd!
  autocmd ColorScheme PaperColorSlim highlight Normal guibg=NONE
augroup end

" ------ Coc.nvim ------
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
" set signcolumn=yes

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

xmap <Space>a <Plug>(coc-codeaction-selected)<CR>coc#refresh()
nmap <Space>a <Plug>(coc-codeaction-selected)<CR>coc#refresh()

nnoremap <c-j> <Plug>(coc-diagnostic-next-error)
nnoremap <c-k> <Plug>(coc-diagnostic-prev-error)

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
nmap <Space>rn <Plug>(coc-rename)

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

nmap <silent> <Space>b :tab term [ -e "bench.sh" ] && (./bench.sh \|\| true) \|\| cargo bench -- --nocapture<CR>i
nmap <silent> <Space>i :tab ter<CR>i
nmap <silent> <Space>t :tab term [ -e "test.sh" ] && (./test.sh \|\| true) \|\| cargo t -- --nocapture --test-threads=1<CR>i
nmap <silent> <Space>d :tab ter [ -e "dev.sh" ] && (./dev.sh \|\| true) \|\| cargo r<CR>i
nmap <silent> <Space>e :tab term [ -e "debug.sh" ] && (./debug.sh \|\| true) \|\| cargo check<CR>i
nmap <silent> <Space>1 :set bg=light<CR>:colo PaperColorSlim<CR>
nmap <silent> <Space>2 :set bg=dark<CR>:colo gruvbox<CR>
" nmap <silent> <Space>e :tabnew<CR>:term [ -e "debug.sh" ] && (./debug.sh \|\| true) \|\| cargo check<CR>i
nmap <silent> <Space>n :NERDTreeCWD<CR>
nmap <silent> <Space>f :NERDTreeFocus<CR>A

inoremap <C-/> \|
inoremap <C-.> \

" penumbra+
" rose_pine
" snazzy
" sonokai
" tokyonight_moon
" varua
" vim_dark_highcontrast
" yo
" zed
