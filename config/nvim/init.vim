" Leader = space
let mapleader = " "

" Ctrl-Backspace deleta a palavra inteira
inoremap <C-h> <C-\><C-o>db

" Highlighting
syntax on

" Número de linhas abaixo do cursor
set scrolloff=10

" Muda o diretório de trabalho para o diretório do arquivo aberto
autocmd BufEnter * silent! lcd %:p:h

" Cursor no centro da tela quando se usa j ou k
nnoremap j jzz
nnoremap k kzz

" Usa a seleção do sistema
set clipboard+=unnamedplus

" Ctrl+q substitui :q!
map <C-q> :quit!<CR>
"nmap q :quit!<CR>

" limpa a busca
nnoremap <F3> :noh<CR>

" Buffers
" ==========
nnoremap gb :ls<CR>:b<Space>
set wildcharm=<C-z>
set wildmode=list:full
set wildignorecase
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
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

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

" Função de substituição
nnoremap <leader>S :%s//gI<Left><Left><Left>

" Vai até o próximo match da seleção e o altera
nnoremap <leader><Tab> ncgn

" Lista de Plugins
" ==========
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'itchyny/lightline.vim'
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'unblevable/quick-scope'
Plug 'dbmrq/vim-ditto'
Plug 'ap/vim-css-color'
call plug#end()

set mouse=a
set title
set relativenumber
set number
set spelllang=pt

augroup my-colors
  autocmd!
  autocmd ColorScheme * hi Normal guibg=NONE ctermbg=NONE
  autocmd ColorScheme * hi NormalNC guibg=#303536 ctermbg=grey
  autocmd ColorScheme * hi clear SpellBad
  autocmd ColorScheme * hi SpellBad guibg=#ff2929 ctermbg=224
  autocmd Colorscheme * hi clear LineNr
  autocmd Colorscheme * set cursorline
augroup END

set termguicolors
colorscheme gruvbox

"exmode - gq instead of Q
map Q gq

" Lightline
" ====================
" theme
let g:lightline = {
      \ 'colorscheme': 'simpleblack',
      \ }
" Always show statusline
set laststatus=2
" Uncomment to prevent non-normal modes showing in powerline and below powerline.
set noshowmode

" spellcheck
map <leader>o :setlocal spell! spelllang=pt<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler <c-r>%<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" visualizador do mdf compilado em pdf
let g:md_pdf_viewer="zathura"

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

" Deoplete
" ======================
let g:deoplete#enable_at_startup = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Vimtex completion
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" Autocompletar
"set wildmode=longest,list,full

"Define o zathura como visualizador do vim-tex
let g:tex_flavor = "latex"
let g:vimtex_view_general_viewer = 'zathura'

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
autocmd FileType markdown nnoremap ,def :-1read $HOME/.config/nvim/snip/markdown/pre<CR>/++<CR>cgn

" Latex related mappings
" ==========
" Usa o plugin vimtex para compilar arquivos .tex
autocmd FileType tex nmap <buffer> <F5> <localleader>ll

"autocmd FileType tex nnoremap ,def :-1read $HOME/.config/nvim/snip/latex/artigo.tex<CR>
autocmd FileType tex nnoremap ,def :-1read $HOME/.config/nvim/snip/latex/artigo.tex<CR>

autocmd FileType tex nnoremap ,abnt :-1read $HOME/docs/tex/templates/mytemplates/abnt.tex<CR>

autocmd FileType tex,markdown inoremap ,st \section{}<Esc>i
autocmd FileType tex,markdown inoremap ,sst \subsection{}<Esc>i
autocmd FileType tex,markdown inoremap ,ssst \subsubsection{}<Esc>i
autocmd FileType tex,markdown inoremap ,lsi \begin{itemize}<CR>\end{itemize}<Esc>kA<CR>\item 
autocmd FileType tex,markdown inoremap ,lse \begin{enumerate}<CR>\end{enumerate}<Esc>kA<CR>\item 
autocmd Filetype tex,markdown inoremap ,dc \documentclass[]{}<Esc>i
autocmd Filetype tex,markdown inoremap ,usp \usepackage{}<Esc>i
autocmd Filetype tex,markdown inoremap ,bd \begin{document}<CR><CR>\end{document}<Esc>kA
autocmd Filetype tex,markdown inoremap ,bg \begin{}<CR>\end{}<Esc>k$i
autocmd Filetype tex,markdown inoremap ,neg \textbf{}<Esc>i
autocmd Filetype tex,markdown inoremap ,ita \textit{}<Esc>i
autocmd Filetype tex,markdown inoremap ,fn \footnote{}<Esc>i
autocmd Filetype tex,markdown inoremap ,sub \textsubscript{}<Esc>i
autocmd Filetype tex,markdown inoremap ,sup \textsuperscript{}<Esc>i
autocmd Filetype tex,markdown inoremap ,nd $\emptyset$
autocmd FileType tex inoremap " ``''<Esc>hi
autocmd FileType tex inoremap ' `'<Esc>i
autocmd FileType tex,markdown inoremap [ []<Esc>i
autocmd FileType tex,markdown inoremap ( ()<Esc>i
autocmd FileType tex,markdown inoremap { {}<Esc>i
"autocmd FileType tex inoremap ,` ``

"Bibliography
autocmd Filetype bib nnoremap ,art :read $HOME/.config/nvim/snip/latex/art.bib<CR>/++<CR>cgn
autocmd Filetype bib nnoremap <silent> ,bk :read $HOME/.config/nvim/snip/latex/book.bib<CR>/++<CR>cgn

