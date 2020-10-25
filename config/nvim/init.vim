let mapleader = " "

" Usa a seleção do sistema
set clipboard+=unnamedplus

" Ctrl+q substitui :q!
"map <C-q> :quit!<CR>
"nmap q :quit!<CR>

" Indentação automática
map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>

" Navegação entre tela dividida
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Navegação entre abas
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

" ctrl l vai para a ultima aba aberta
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-l> :exe "tabn ".g:lasttab<cr>

" Redimensiona verticalmente quando há duas janelas
map <c-n> <c-w><
map <c-m> <c-w>>

" Função de substituição
nnoremap S :%s//gI<Left><Left><Left>


" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let fname = Chomp(system("find ~/Documentos -name '*.py' | dmenu -i -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

function! DmenuOpentex(cmd)
  let fname = Chomp(system("find ~/Documentos -name '*.tex' | dmenu -i -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

" ctrl t abre o arquivo em nova aba
autocmd FileType python map <c-t> :call DmenuOpen("tabe")<cr>
autocmd FileType python map <c-f> :call DmenuOpen("e")<cr>

" ctrl t abre o arquivo em nova aba
autocmd FileType tex map <c-t> :call DmenuOpentex("tabe")<cr>
autocmd FileType tex map <c-f> :call DmenuOpentex("e")<cr>

"Lista de Plugins
call plug#begin('~/local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'
"Plug 'conornewton/vim-pandoc-markdown-preview'
Plug 'junegunn/goyo.vim'
"Plug 'junegunn/limelight.vim'
Plug 'unblevable/quick-scope'
"Plug 'dbmrq/vim-ditto'
Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'arcticicestudio/nord-vim'
call plug#end()

set termguicolors
colorscheme dracula

set mouse=a
set title
syntax on
set relativenumber
set spelllang=pt

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

" visualizador do mdf compilado em pdf
let g:md_pdf_viewer="zathura"

" Goyo
map <leader>g :Goyo<CR>

" Limelight
map <leader>l :Limelight!!<CR>
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240
" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" deoplete
let g:deoplete#enable_at_startup = 1

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Vimtex completion
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" Autocompletar
set wildmode=longest,list,full

" Inverte o split - Novas janelas abrirao na direita e embaixo
set splitbelow splitright

"Define o zathura como visualizador do vim-tex
let g:tex_flavor = "latex"
let g:vimtex_view_general_viewer = 'zathura'

" nerd tree
map <leader>f :NERDTreeToggle<CR>

"Override BG
autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE

" airline
let g:airline#extensions#wordcount#enabled = 1
let g:airline_theme='minimalist'

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

"autocmd FileType tex nnoremap <buffer> <F5> :!pdflatex %:t<CR><CR>
"autocmd FileType tex nnoremap <buffer> <F6> :!zathura %:r.pdf<CR><CR>
" Usa o plugin vimtex para compilar arquivos .tex
autocmd FileType tex nmap <buffer> <F5> <localleader>ll

"autocmd FileType markdown nnoremap <buffer> <F5> :!pandoc % -o %:r.pdf<CR><CR>
"autocmd FileType markdown nnoremap <buffer> <F6> :!zathura %:r.pdf<CR><CR>
" Usa o plugin vim pandoc markdown para compilar e visualizar arquivos .md
autocmd FileType markdown nmap <F5> :StartMdPreview<CR><CR>

" Run programas python
autocmd FileType python nmap <leader>r :w <bar> !python %<CR>
autocmd FileType python nmap <leader><Enter> :te<CR>i<CR>
autocmd FileType python tnoremap <C-q> exit<CR>
autocmd FileType python imap ,pr print()<Esc>i


"LATEX SHORTCUTS
autocmd FileType tex inoremap ,st \section{}<Esc>i
autocmd FileType tex inoremap ,sst \subsection{}<Esc>i
autocmd FileType tex inoremap ,ssst \subsubsection{}<Esc>i
autocmd FileType tex inoremap ,lsi \begin{itemize}<CR>\end{itemize}<Esc>kA<CR>\item 
autocmd FileType tex inoremap ,lse \begin{enumerate}<CR>\end{enumerate}<Esc>kA<CR>\item 
autocmd Filetype tex inoremap ,dc \documentclass[]{}<Esc>i
autocmd Filetype tex inoremap ,usp \usepackage{}<Esc>i
autocmd Filetype tex inoremap ,bd \begin{document}<CR><CR>\end{document}<Esc>kA
autocmd Filetype tex inoremap ,neg \textbf{}<Esc>i
autocmd Filetype tex inoremap ,ita \textit{}<Esc>i
autocmd Filetype tex inoremap ,fn \footnote{}<Esc>i
autocmd Filetype tex inoremap ,sub \textsubscript{}<Esc>i
autocmd Filetype tex inoremap ,sup \textsuperscript{}<Esc>i
autocmd Filetype tex inoremap ,nd $\emptyset$
autocmd Filetype tex inoremap ,start \documentclass[]{article}<CR><CR>\usepackage[portuguese]{babel}<CR>\usepackage{times}<CR>\usepackage{indentfirst}<CR>\usepackage{geometry}<Esc>A<CR><Tab>\geometry {<CR>top=3cm,<CR>bottom=3cm,<CR>right=3cm,<CR>left=3cm,<CR>}<CR><CR><BS>\begin{document}<CR><CR><CR>\end{document}<Esc>kO
autocm Filetype tex inoremap ,abnt \documentclass[<CR><Tab>article,<CR>11pt,<CR>oneside,<CR>a4paper,<CR>english,<CR>brazil,<CR>sumario=tradicional<CR>]{abntex2}<CR><CR><BS>% PACOTES BÁSICOS<CR><BS>\usepackage{lmodern}<CR>\usepackage[T1]{fontenc}<CR>\usepackage{indentfirst}<CR>\usepackage{nomencl}<CR>\usepackage{color}<CR>\usepackage{graphicx}<CR>\usepackage{microtype}<CR><CR>% PACOTES DE CITACAO<CR>\usepackage[brazilian,hyperpageref]{backref}<Tab>% Bibliografia<CR>\usepackage[alf]{abntex2cite}<Tab>% Citacoes no texto<CR>
