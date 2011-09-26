" Indent without helping me.
set autoindent

" Incremental search is *awesome*
set incsearch

" Have tabs 3 chars long...
set tabstop=3
set shiftwidth=3

set copyindent

" Wrap lines automatically
set textwidth=72

" Don't let me further than 1 line towards the end or the beginning.
set scrolloff=1

" Have syntax highlighting and non-vi features
syntax on
set nocompatible

set fileencodings=utf-8

" Allow me to delete with backspace
set backspace=indent,eol,start

"""
call pathogen#runtime_append_all_bundles()

""" Mappin' stuff around a little bit (please :)
map q :quit<CR>
map Q :quitall<CR>
" Note the space after ':tabnew' ;)
"map t :tabnew 
noremap <Space> :NERDTree<CR>
noremap <c-b> :make<CR>
noremap <c-t> :CommandT<CR>
noremap <c-n> :tabnew<CR>:CommandT<CR>
noremap <c-f> :!ack 

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

" ZenCoding. Very fast tag structure creating and friends..
autocmd BufNewFile,BufRead *.{html,css,xml} runtime plugin/zencoding.vim

autocmd BufNewFile,BufRead *.arc set ft=lisp

" Local .vimrc files
if filereadable('.vimrc')
	source .vimrc
endif
