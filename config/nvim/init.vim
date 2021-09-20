" Leader = space
let mapleader = " "

" Highlighting
syntax on

" Autocompletion
" ==============
" Permite usar o autocomplete com um dicionário
set complete+=kspell
" Mostra o menu de autocomplete mesmo quando há apenas 1 match
set completeopt=menuone,longest
" Não mostra o número de matches
set shortmess+=c
" Seleciona um item com o Tab
inoremap <expr> <Tab> pumvisible() ? "<C-y>" : "<Tab>"

" Número de linhas abaixo do cursor
set scrolloff=10

" Muda o diretório de trabalho para o diretório do arquivo aberto
autocmd BufEnter * silent! lcd %:p:h

" Cursor no centro da tela quando se usa j ou k
nnoremap j jzz
nnoremap k kzz
" Cursor no centro da tela sempre
function! CentreCursor()
    let pos = getpos(".")
    normal! zz
    call setpos(".", pos)
endfunction

autocmd CursorMoved,CursorMovedI * call CentreCursor()

" Usa a seleção do sistema
set clipboard+=unnamedplus

" Ctrl+q substitui :q!
map <C-q> :quit!<CR>

" limpa a busca
nnoremap <F3> :noh<CR>

" Buffers
" ==========
"nnoremap gb :ls<CR>:b<Space>
set wildcharm=<C-z>
set wildmode=list:full
set wildignorecase
set hidden
nnoremap <leader>bd :bd<CR>
nnoremap <leader>lb :buffer! <C-z><S-Tab>
nnoremap <leader>vb :vert sbuffer! <C-z><S-Tab>
nnoremap <leader>sb :sbuffer! <C-z><S-Tab>
nnoremap <leader>bp :bprevious!<CR>
nnoremap <leader>bn :bnext!<CR>

" Tabs
" ==========
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=4                " One tab == four spaces.
set tabstop=4                   " One tab == four spaces.

" Splits
" ==========
set splitbelow splitright
map <leader>wh <C-w>h
map <leader>wj <C-w>j
map <leader>wk <C-w>k
map <leader>wl <C-w>l
" Closing splits
map <leader>wc <C-w>q
" Make adjusing split sizes a bit more friendly
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
" Change 2 split windows from vert to horiz or horiz to vert
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Abas
" ==========
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" Redimensiona verticalmente splits
map <c-n> <c-w><
map <c-m> <c-w>>

" Função de substituição em todo o documento
nnoremap <leader>S :%s//gI<Left><Left><Left>

" Vai até o próximo match da seleção e o altera
nnoremap <leader><Tab> ncgn


" Lista de Plugins
" ==========
call plug#begin('~/.local/share/nvim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'unblevable/quick-scope'
Plug 'dbmrq/vim-ditto'
Plug 'gdetrez/vim-gf'
call plug#end()


set mouse=a
set title
set relativenumber
set number
set spelllang=pt

augroup my-colors
  autocmd!
  autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
  "autocmd ColorScheme * hi NormalNC guibg=#303536 ctermbg=grey
  autocmd ColorScheme * hi clear SpellBad
  autocmd ColorScheme * hi SpellBad guibg=#ff2929 ctermbg=224
  autocmd Colorscheme * hi clear LineNr
  autocmd Colorscheme * set cursorline
augroup END

set termguicolors
colorscheme dracula

"exmode - gq instead of Q
map Q gq

" spellcheck
map <leader>o :setlocal spell! spelllang=pt<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Fzf
nnoremap <leader>f :Files ~<CR>
nnoremap <leader>bb :Buffers<CR>

" Vim-Easy-Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" Align GitHub-flavored Markdown tables
vmap <Leader><Bar> :EasyAlign*<Bar><Enter>

" Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_winsize = 20
autocmd FileType netrw setl bufhidden=delete
map <leader>e :Explore<CR>
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" Goyo
" ======================
map <leader>g :set cursorline! <bar> hi NormalNC guibg=NONE ctermbg=NONE <bar> Goyo<CR>

" quiting in goyo quits the file
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" lightline
" =========

" theme
let g:lightline = {
      \ 'colorscheme': 'simpleblack',
      \ }
" Always show statusline
set laststatus=2
" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

" Limelight
" ==========

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

let g:tex_flavor = "latex"

" vim-ditto
nmap <leader>di <Plug>ToggleDitto      " Turn Ditto on and off
nmap =d <Plug>DittoNext                " Jump to the next word
nmap -d <Plug>DittoPrev                " Jump to the previous word
nmap +d <Plug>DittoGood                " Ignore the word under the cursor
nmap _d <Plug>DittoBad                 " Stop ignoring the word under the cursor
nmap ]d <Plug>DittoMore                " Show the next matches
nmap [d <Plug>DittoLess                " Show the previous matches

autocmd BufRead /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown

autocmd Filetype rmd map <F5> :!echo<space>"require(rmarkdown);<space>render('<c-r>%')"<space>\|<space>R<space>--vanilla<enter>

" Python related mappings
" ==========
autocmd FileType python nmap <leader>r :w <bar> !python %<CR>
autocmd FileType python nmap <leader>i :w <bar> te python -i %<CR>
autocmd FileType python nmap <leader><Enter> :te<CR>i<CR>
autocmd FileType python tnoremap <C-q> exit<CR>
autocmd FileType python inoremap ,pr print()<Esc>i
autocmd FileType python inoremap " ""<Esc>i
autocmd FileType python inoremap ' ''<Esc>i
autocmd FileType python inoremap [ []<Esc>i
autocmd FileType python inoremap ( ()<Esc>i
autocmd FileType python inoremap { {}<Esc>i

" Markdown related mappings
" =========
autocmd FileType markdown,rmd nnoremap ,def :-1read $HOME/.config/nvim/snip/markdown/pre<CR>/++<CR>cgn

" Latex related mappings
" ==========
"autocmd FileType tex nnoremap ,def :-1read $HOME/.config/nvim/snip/latex/artigo.tex<CR>
autocmd FileType tex nnoremap ,def :-1read $HOME/.config/nvim/snip/latex/artigo.tex<CR>
autocmd FileType tex nnoremap ,ba :-1read /home/joao/.config/nvim/snip/latex/basico.tex<CR>
autocmd FileType tex nnoremap ,apre :-1read /home/joao/.config/nvim/snip/latex/apresentacao.tex<CR>

autocmd FileType tex nnoremap ,abnt :-1read $HOME/docs/tex/templates/mytemplates/abnt.tex<CR>

autocmd FileType tex,markdown,rmd inoremap ,st \section{}<Esc>i
autocmd FileType tex,markdown,rmd inoremap ,sst \subsection{}<Esc>i
autocmd FileType tex,markdown,rmd inoremap ,ssst \subsubsection{}<Esc>i
autocmd FileType tex,markdown,rmd inoremap ,lsi \begin{itemize}<CR>\end{itemize}<Esc>kA<CR>\item 
autocmd FileType tex,markdown,rmd inoremap ,lse \begin{enumerate}<CR>\end{enumerate}<Esc>kA<CR>\item 
autocmd Filetype tex,markdown,rmd inoremap ,dc \documentclass[]{}<Esc>i
autocmd Filetype tex,markdown,rmd inoremap ,usp \usepackage{}<Esc>i
autocmd Filetype tex,markdown,rmd inoremap ,bd \begin{document}<CR><CR>\end{document}<Esc>kA
autocmd Filetype tex,markdown,rmd inoremap ,bg \begin{}<CR>\end{}<Esc>k$i
autocmd Filetype tex,markdown,rmd inoremap ,fr \begin{frame}<CR>\frametitle{}<CR>\end{frame}<Esc>O\begin{minipage}{0.95\textwidth}<CR>\end{minipage}<CR>\begin{minipage}{0.4\textwidth}<CR>\end{minipage}<Esc>4ki
autocmd Filetype tex,markdown,rmd inoremap ,neg \textbf{}<Esc>i
autocmd Filetype tex,markdown,rmd inoremap ,ita \textit{}<Esc>i
autocmd Filetype tex,markdown,rmd inoremap ,fn \footnote{}<Esc>i
autocmd Filetype tex,markdown,rmd inoremap ,sub \textsubscript{}<Esc>i
autocmd Filetype tex,markdown,rmd inoremap ,sup \textsuperscript{}<Esc>i
autocmd Filetype tex,markdown,rmd inoremap ,nd $\emptyset$
autocmd Filetype tex,markdown,rmd inoremap ,ex \begin{exe}<CR>\end{exe}<Esc>O\ex 
autocmd Filetype tex,markdown,rmd inoremap ,sn \begin{exe}<CR>\end{exe}<Esc>O\sn 
autocmd FileType tex inoremap " ``''<Esc>hi
autocmd FileType tex inoremap ' `'<Esc>i
autocmd FileType tex,markdown,rmd inoremap [ []<Esc>i
autocmd FileType tex,markdown,rmd inoremap ( ()<Esc>i
autocmd FileType tex,markdown,rmd inoremap { {}<Esc>i

"Bibliography
autocmd Filetype bib nnoremap ,art :read $HOME/.config/nvim/snip/latex/art.bib<CR>/++<CR>cgn
autocmd Filetype bib nnoremap <silent> ,bk :read $HOME/.config/nvim/snip/latex/book.bib<CR>/++<CR>cgn

