let mapleader = " "

syntax on

" Usa a seleção do sistema
set clipboard+=unnamedplus

" Ctrl+q substitui :q!
"map <C-q> :quit!<CR>
"nmap q :quit!<CR>

" limpa a busca
nnoremap <F3> :noh<CR>

nnoremap gb :ls<CR>:b<Space>

" Tabs
set expandtab                   " Use spaces instead of tabs.
set smarttab                    " Be smart using tabs ;)
set shiftwidth=4                " One tab == four spaces.
set tabstop=4                   " One tab == four spaces.
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
nnoremap <silent> <c-u> :exe "tabn ".g:lasttab<cr>
vnoremap <silent> <c-u> :exe "tabn ".g:lasttab<cr>

" Redimensiona verticalmente quando há duas janelas
map <c-n> <c-w><
map <c-m> <c-w>>

" Função de substituição
nnoremap <leader>S :%s//gI<Left><Left><Left>

nnoremap <leader><Tab> ncgn

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
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'itchyny/lightline.vim'
"Plug 'tpope/vim-surround'
Plug 'lervag/vimtex'
Plug 'junegunn/goyo.vim'
"Plug 'junegunn/limelight.vim'
Plug 'unblevable/quick-scope'
Plug 'dbmrq/vim-ditto'
Plug 'ap/vim-css-color'
call plug#end()

"set bg=light
set mouse=a
set title
set relativenumber
set number
set spelllang=pt

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
	"autocmd VimLeave *.tex !texclear %

" visualizador do mdf compilado em pdf
let g:md_pdf_viewer="zathura"

" Goyo
" ======================
map <leader>g :Goyo<CR>

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
set wildmode=longest,list,full

" Inverte o split - Novas janelas abrirao na direita e embaixo
set splitbelow splitright

"Define o zathura como visualizador do vim-tex
let g:tex_flavor = "latex"
let g:vimtex_view_general_viewer = 'zathura'

" nerd tree
map <leader>f :NERDTreeToggle<CR>

" Override colors
hi Normal guibg=NONE ctermbg=NONE
"highlight clear CursorLineNR
"highlight clear LineNR
hi clear SpellBad
hi SpellBad guibg=#ff2929 ctermbg=224

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

" Usa o plugin vimtex para compilar arquivos .tex
autocmd FileType tex nmap <buffer> <F5> <localleader>ll

" Usa o plugin vim pandoc markdown para compilar e visualizar arquivos .md
autocmd FileType markdown nmap <F5> :StartMdPreview<CR><CR>

" Run programas python
autocmd FileType python nmap <leader>r :w <bar> !python %<CR>
autocmd FileType python nmap <leader><Enter> :te<CR>i<CR>
autocmd FileType python tnoremap <C-q> exit<CR>
autocmd FileType python imap ,pr print()<Esc>i


"LATEX SHORTCUTS
autocmd FileType tex nnoremap ,def :-1read $HOME/.config/nvim/snip/latex/artigo.tex<CR>30gg

autocmd FileType tex nnoremap <C-p> :silent !phrases<CR>

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

"Bibliography
autocmd Filetype bib nnoremap ,art :read $HOME/.config/nvim/snip/latex/art.bib<CR>/++<CR>cgn
autocmd Filetype bib nnoremap <silent> ,bk :read $HOME/.config/nvim/snip/latex/book.bib<CR>/++<CR>cgn

