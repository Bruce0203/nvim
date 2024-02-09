syntax enable
filetype plugin indent on

call plug#begin('~/.vim/plugged')


Plug 'scrooloose/nerdcommenter'
Plug 'altercation/vim-colors-solarized'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rust-lang/rust.vim'
Plug 'mhinz/vim-startify'

call plug#end()

set number
se t_Co=16
let g:solarized_termcolors=256  

set background=dark
colorscheme solarized

set nobackup
set nowritebackup

set updatetime=300

set signcolumn=yes

" :nmap <Tab> :NERDTreeToggle<CR>
:set modifiable

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

function! ToggleNERDTree()
  " NERDTree가 실행중인지 확인합니다.
  if exists("g:NERDTree") && g:NERDTree.IsOpen()
    " NERDTree가 열려있다면 닫습니다.
    NERDTreeClose
  else
    " 그렇지 않다면 NERDTree를 엽니다.
    NERDTreeToggle
  endif
endfunction

" Tab 키에 ToggleNERDTree 함수를 매핑합니다.
nnoremap <silent> <S-E> :call ToggleNERDTree()<CR>


let g:NERDTreeMinimalMenu=1

let g:NERDCreateDefaultMappings = 1

nnoremap <silent> <c-_>c} V}:call NERDComment('x', 'toggle')<CR>

