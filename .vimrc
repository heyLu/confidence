set nocompatible
filetype off

if isdirectory($HOME . '/.vim/bundle/vundle')
	set runtimepath+=~/.vim/bundle/vundle
	call vundle#rc()

	Bundle 'gmarik/vundle'
	if has('python')
		Bundle 'Valloric/YouCompleteMe'
		let g:ycm_confirm_extra_conf = 0
	endif
	Bundle 'Lokaltog/vim-easymotion'
	"Bundle 'laurilehmijoki/haskellmode-vim'
	"au BufNewFile,BufRead *.hs compiler ghc
	Bundle 'scrooloose/syntastic'
	Bundle 'bitc/vim-hdevtools'
	au FileType haskell noremap <buffer> \ht :HdevtoolsType<CR>
	au FileType haskell noremap <buffer> \hc :HdevtoolsClear<CR>
	Bundle 'tpope/vim-foreplay'

	Bundle 'airblade/vim-gitgutter'
	highlight SignColumn ctermbg=0
	Bundle 'terryma/vim-multiple-cursors'
endif

" Have syntax highlighting and non-vi features
syntax on
filetype plugin indent on

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

function! g:setTextWidthInComments()
	" Capture new position
	let g:curTextPosition = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")

	if( g:curTextPosition == "Comment" || &ft == "markdown" || &ft == "" )
		set textwidth=72
	else
		set textwidth=0
	endif
endfunction
"autocmd CursorMoved * :call g:setTextWidthInComments()

" via <http://paulrouget.com/e/vimdarkroom>
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    set showtabline=0
    hi FoldColumn ctermbg=none
    hi LineNr ctermfg=0 ctermbg=none
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    set showtabline=1
    colorscheme solarized
  endif
endfunc
nnoremap F :call ToggleFocusMode()<cr>

au BufNewFile,BufRead *.{hs,lhs} set comments=:--,sr:{-,ex:-}
au BufNewFile,BufRead *.rb set comments=:#,s:=begin,e:=end
au BufNewFile,BufRead *.{opa,trx} set filetype=opa shiftwidth=2 tabstop=2 expandtab

" Don't let me further than 1 line towards the end or the beginning.
set scrolloff=1

if exists("pathogen")
	call pathogen#infect('~/t/vim/')
	call pathogen#infect('~/t/rust/src/etc/')
	let g:ctrlp_custom_ignore = {
		\ 'dir': '\.git$'
	\ }
	let g:ctrlp_prompt_mappings = {
		\ 'PrtClearCache': ['<F12>']
	\ }
	call pathogen#infect('~/t/notmuch/')
	call pathogen#infect('~/t/vim/clojure')
	let g:vimclojure#ParenRainbow=1
	let g:vimclojure#NailgunClient="/home/lu/t/vim/clojure/client/ng"
	let g:vimclojure#WantNailgun=0

	" soo beautiful! :)
	set background=dark
	let g:solarized_termtrans  = 0
	let g:solarized_termcolors = 16
	colorscheme solarized
endif

" Show whitespace
set list
set listchars=tab:→\ ,trail:·,eol:¬
"highlight SpecialKey ctermfg=10 ctermbg=8
"highlight NonText ctermfg=10 ctermbg=8

set fileencodings=utf-8

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
map <c-b> :make<CR> " build
" Fuzzy finding (http://thechangelog.com/post/15573551543)
noremap <C-e> :CtrlP<CR>
"noremap <C-p> :tabnew<CR>:CtrlP<CR>
map <c-f> :!ack
nmap <c-a> :w<CR>
map <Leader>t :TagbarToggle<CR>

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
