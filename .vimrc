set nocompatible
filetype off

if isdirectory($HOME . '/.vim/bundle/vundle')
	set runtimepath+=~/.vim/bundle/vundle
	call vundle#rc()

	Bundle 'fatih/vim-go'
	Bundle 'adborden/vim-notmuch-address'
endif

" Have syntax highlighting and non-vi features
filetype plugin indent on

set t_Co=256

highlight LineNr ctermfg=Gray guifg=Gray
highlight SpecialKey ctermfg=LightGray guifg=LightGray
highlight NonText ctermfg=LightGray guifg=LightGray

" Indent without helping me.
set autoindent

" Incremental search is *awesome*
set incsearch
set ignorecase " ignore case
set smartcase " unless pattern contains uppercase

" Some wildcard tweaking
set wildignore=*.hi,*.o
set wildmenu

" Have tabs 3 chars long...
set tabstop=3
set shiftwidth=3
set smarttab
set nopaste
set pastetoggle=<F12>

set mouse=a

set number " With numbertoggle they're quite cool (I think)

" Copy indent of the last line.
set copyindent

" Keep a longer history
set history=1000

" Keep buffers when closing them (useful?)
set hidden

" Oh YEAY, finally. Store them (swaps) all in *one* directory.
set directory=~/.vim/tmp/
set undodir=~/.vim/tmp/
set undofile

let &t_ts = "\e]2;"
let &t_fs = "\007"
set title
set titleold=
au BufEnter * let &titlestring=substitute(expand('%:p'), '^' . $HOME, '~', '')

" Wrap lines in textfiles automatically.
" (Any way to enable in comments?)
set textwidth=72
au FileType text set textwidth=72

au BufNewFile,BufRead *.{hs,lhs} set comments=:--,sr:{-,ex:-}
au BufNewFile,BufRead *.rb set comments=:#,s:=begin,e:=end
au BufNewFile,BufRead *.{opa,trx} set filetype=opa shiftwidth=2 tabstop=2 expandtab
au BufNewFile,BufRead *.pxi set filetype=clojure

" Don't let me further than 1 line towards the end or the beginning.
set scrolloff=1

set fileencodings=utf-8
set encoding=utf-8

" Show whitespace
set list
set listchars=tab:→\ ,trail:·,eol:¬
"highlight SpecialKey ctermfg=10 ctermbg=8
"highlight NonText ctermfg=10 ctermbg=8

" Automatically reread the file if it has been changed from the outside
set autoread

" Allow me to delete with backspace
set backspace=indent,eol,start

""" Mappin' stuff around a little bit (please :)
" disabling the arrow keys (maybe remap useful things to them later):
" http://jeetworks.org/node/89
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
" be a bit more like emacs
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>
" navigate long lines easier
noremap   j        gj
noremap   k        gk
" Move easier between windows
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
" remaps
noremap U <c-r>
noremap <c-r> q
"noremap j k
"noremap k j
map q :quit<CR>
map Q :quitall<CR>
" save a 'project'
map <leader>ps :mksession! .project.vim
map <leader>pl :source .project.vim
" fancy maps
map <Space> :NERDTree<CR>
map <c-m> :!make<CR>
map <c-b> :make<CR> " build
" Fuzzy finding (http://thechangelog.com/post/15573551543)
"noremap <C-e> :CtrlP<CR>
"noremap <C-p> :tabnew<CR>:CtrlP<CR>
"map <c-f> :!ack
"nmap <c-a> :w<CR>
map <Leader>t :TagbarToggle<CR>

"" mappings and options inspired by https://www.vi-improved.org/recommendations/
nnoremap <leader>q :b#<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>e :Files<cr>
nnoremap <leader>s :Ag<cr>
"nnoremap <leader>b :b <c-d>
"nnoremap <leader>e :e **/

inoremap ,f <c-x><c-f>
inoremap ,n <c-x><c-n>

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]

nnoremap <leader>S :if exists("g:syntax_on") <Bar> syntax off <Bar> else <Bar> syntax enable <Bar> endif <CR>

""" Filetype specific stuff comes now...

" Have Vala highlighted, too
autocmd BufRead *.{vala,vapi} set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.{vala,vapi} setfiletype vala

" And now some *really* fancy completion stuff
" (Of course I've not written this ;)
set runtimepath+=/home/mimi/t/vim/vim-ruby
augroup rubyish
	au BufNewFile,BufRead *.rb set omnifunc=rubycomplete#Complete
	au BufNewFile,BufRead *.rb set makeprg=ruby\ %
	au BufNewFile,BufRead *.rb map <C-X> :make<CR>
	au BufNewFile,BufRead *.rb set ts=2 sw=2 expandtab
augroup END

au BufNewFile,BufRead *.n3 set ft=n3
au BufNewFile,BufRead *.asd set ft=lisp
au BufNewFile,BufRead *.citrus set ft=citrus

au BufNewFile,BufRead *.{hs,lhs,chs} set ts=4 sw=4 expandtab

au BufNewFile,BufRead *.{py} set ts=4 sw=4 expandtab nolist

" ZenCoding. Very fast tag structure creating and friends..
autocmd BufNewFile,BufRead *.{html,css,xml} runtime plugin/zencoding.vim

autocmd BufNewFile,BufRead *.arc set ft=lisp
autocmd BufNewFile,BufRead *.md set ft=markdown sw=4 ts=4 expandtab

autocmd BufNewFile,BufRead *.{vert,frag} set ft=glsl

autocmd BufNewFile,BufRead *.{c,h} set tags=~/stdlib.tags,~/posix.tags

set runtimepath+=/usr/share/lilypond/2.14.2/vim
autocmd BufNewFile,BufRead *.ly set filetype=lilypond

autocmd BufNewFile,BufRead *.java set include=^#\s*import
autocmd BufNewFile,BufRead *.java set includeexpr=substitute(v:fname,'\\.','/','g')
autocmd BufNewFile,BufRead *.java set shiftwidth=4 tabstop=4 expandtab
let g:syntastic_java_checkers = []

autocmd BufNewFile,BufRead *.{yml,yaml} set shiftwidth=2 tabstop=2 expandtab

if filereadable('~/ruby-1.9.4dev/lib/ruby/gems/1.9.1/gems/rcodetools-0.8.5.0/rcodetools.vim')
	source ~/ruby-1.9.4dev/lib/ruby/gems/1.9.1/gems/rcodetools-0.8.5.0/rcodetools.vim
endif

" Plugin settings

set laststatus=2
let g:Powerline_symbols='fancy'

" Local .vimrc files
if getcwd() != $HOME && filereadable('.vimrc')
	source .vimrc
endif

if filereadable('.project.vim') && expand("%") == ""
	silent source .project.vim
endif
