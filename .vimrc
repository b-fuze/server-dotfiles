execute pathogen#infect()

syntax on
filetype plugin indent on
colorscheme apprentice

set mouse=a ttymouse=xterm2
set number relativenumber
set shiftwidth=2 tabstop=2 expandtab
set nowrap
set cursorline
set showtabline=2
set termguicolors
set laststatus=2
set autoindent
set encoding=utf8
set hidden
set hlsearch

" I only need lightline to tell me the current mode
set noshowmode

" Ctrl-A jumps to the beginning of the line in ex mode
cnoremap <c-a> <Home>

" Prevent trailing newlines
set nofixendofline
set noeol

" Wrapping respects indent
set breakindent

" Use clean split char
set fillchars=vert:▏,diff:⸱

" Use good vert split color
highlight VertSplit term=reverse ctermfg=233 guifg=#303030 guibg=#1c1c1c

" Preserve syntax highlighting when selecting in visual mode
hi Visual guifg=NONE guibg=#383838 gui=NONE cterm=NONE

" Remove tabline X closing tabs added by lightline
let g:lightline = {
  \   "tabline": {
  \     "left": [["tabs"]],
  \     "right": [],
  \   },
  \ }

" Include full buffer
" TODO: separate the total lines to its own lightline component
" to make it bold or something to separate it visually from
" current line/column
let g:lightline.component = {
  \   "lineinfo": "%3l/%L ↦ %-2c"
  \ }

" Neutral color for the tabline
let s:powerline_colors = g:lightline#colorscheme#powerline#palette
let s:powerline_colors.tabline.middle = [["gray2", "#353535"]]
let g:lightline#colorscheme#powerline#palette = lightline#colorscheme#fill(s:powerline_colors)

" Set timeoutlen and ttimeoutlen
set timeoutlen=150 ttimeoutlen=0

" show our whitespace
set listchars=tab:\|\ ,trail:.
set list

" Prevent screen flash
set t_vb=

" Show search occurence count and current occurence
set shortmess-=S

" Preview windows should be at the bottom
set splitbelow

" Prevent tcomment from overloading <c-_> (<c-/>)
let g:tcomment_mapleader1 = "<Nop>"

" Quick comment visual block
vmap <silent> <c-_> <Plug>TComment_gc
" Toggle commenting current line
nmap <silent> <c-_> <Plug>TComment_gcc
" Comment the current line from insert mode
imap <c-_> <c-o><Plug>TComment_gcc

" Remember last file position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Move lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
