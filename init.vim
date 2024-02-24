" ------ basics ------
set encoding=utf-8
syntax enable
filetype plugin indent on
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes

" ------ plugins ------
call plug#begin('~/.vim/plugged')
Plug 'timonv/vim-cargo'
Plug 'vim-test/vim-test'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jbyuki/venn.nvim'
Plug 'tpope/vim-fugitive'
" Plug 'flazz/vim-colorschemes'
Plug 'Bruce0203/vim-airline-papercolor-theme'
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
set number
set t_Co=256   " This is may or may not needed.
set laststatus=2
" let g:solarized_termcolors=256  
set background=light
" jellyx, herald, jelleybeans
colorscheme PaperColor
" :nmap <Tab> :NERDTreeToggle<CR>
:set modifiable
function! ToggleNERDTree()
  if exists("g:NERDTree") && g:NERDTree.IsOpen()
    NERDTreeClose
  else
    NERDTreeToggle
  endif
endfunction

nnoremap <silent> <Tab> :call ToggleNERDTree()<CR>
nnoremap <silent> <s-Tab> :NERDTreeCWD<CR>


" let g:NERDTreeMinimalMenu=1

let g:NERDCreateDefaultMappings = 1

nnoremap <silent> <c-_>c} V}:call NERDComment('x', 'toggle')<CR>


nmap <Leader>r :NERDTreeFocus<cr>R<c-w><c-p>




" ------ Coc.nvim ------
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call ShowDocumentation()<CR>
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

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')


" Applying code actions to the selected code block
" Example: `<c-a-ap` for current paragraph
xmap <c-a>  <Plug>(coc-codeaction-selected)<CR>
nmap <c-a>  <Plug>(coc-codeaction-selected)<CR>

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

" Symbol renaming
nmap <silent> <s-f> :Format<CR>
nmap <silent> <s-q> <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" ------ papercolor airline ------
let g:airline_theme='papercolor'

" ------ Test ------
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

let g:test#rust#runner = 'cargotest'
let test#ruby#minitest#options = '--verbose'
let g:test#rust#cargotest#options = '-- --nocapture'



