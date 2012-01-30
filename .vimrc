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

" Copy indent of the last line.
set copyindent

" Show whitespace
"set list listchars=tab:»·,trail:·
"au BufNewFile,BufRead *.{c,h} set listchars=tab:\ \ ,trail:·

" Keep a longer history
set history=100

" Oh YEAY, finally. Store them (swaps) all in *one* directory.
set directory=~/.vim/tmp/

" Wrap lines in textfiles automatically.
" (Any way to enable in comments?)
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

autocmd CursorMoved * :call g:setTextWidthInComments()

au BufNewFile,BufRead *.{hs,lhs} set comments=:--,sr:{-,ex:-}
au BufNewFile,BufRead *.rb set comments=:#,s:=begin,e:=end
au BufNewFile,BufRead *.{opa,trx} set filetype=opa shiftwidth=2 tabstop=2 expandtab

" Don't let me further than 1 line towards the end or the beginning.
set scrolloff=1

"""
call pathogen#infect('~/t/vim/')
call pathogen#infect('~/t/notmuch/')

" Have syntax highlighting and non-vi features
syntax on
set nocompatible

" soo beautiful! :)
let g:solarized_termtrans=1 " Somehow needed to make some places (empty space etc.) beautiful aswell
set background=dark
colorscheme solarized

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
" remaps
noremap U <c-r>
noremap <c-r> q
"noremap j k
"noremap k j
map q :quit<CR>
map Q :quitall<CR>
" fancy maps
map <Space> :NERDTree<CR>
map <c-b> :make<CR> " build
" Fuzzy finding (http://thechangelog.com/post/15573551543)
nmap <C-e> :CtrlP<CR>
nmap <C-p> :tabnew<CR>:CtrlP<CR>
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
autocmd BufNewFile,BufRead *.md set ft=markdown

autocmd BufNewFile,BufRead *.{vert,frag} set ft=glsl

autocmd BufNewFile,BufRead *.{c,h} set tags=~/stdlib.tags,~/posix.tags

" Make folds a little more acceptable :)
highlight Folded ctermbg=255

source ~/ruby-1.9.4dev/lib/ruby/gems/1.9.1/gems/rcodetools-0.8.5.0/rcodetools.vim

" Local .vimrc files
if getcwd() != $HOME && filereadable('.vimrc')
	source .vimrc
endif
