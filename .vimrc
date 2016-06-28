se nu
syntax on
colorscheme jellybeans
set autoindent
" set smartindent
set hlsearch
" set expandtab

" search during typing
set incsearch

set nolinebreak
set pastetoggle=<F2>

match ErrorMsg '\%>80v.\+' " Right margin
2match ErrorMsg '\s\+$'      " Trailing whitespaces

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

:filetype plugin on

command Gnu setl sw=2 sws=2 sts=2 ts=2 et

" coding styles
" autocmd FileType C setl sw=8 sts=8 ts=8
" autocmd FileType python setl sw=4 sts=4 ts=4 et
" autocmd FileType C++ setl sw=4 sts=4 ts=4 et
autocmd FileType cpp setl sw=4 sts=4 ts=4 et
autocmd FileType haskell setl sw=4 sts=4 ts=4 et
autocmd FileType make setl sts=8 sw=8 ts=8 noexpandtab
augroup filetype
      au! BufRead,BufNewFile *.ll     set filetype=llvm
      au! BufRead,BufNewFile *.llvm   set filetype=llvm
      au! BufRead,BufNewFile *.cpp    set filetype=cpp
augroup END

" add first tags in tree on the way to root
set tags=./tags;/

" taglist
map <F3> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow=1
let Tlist_GainFocus_On_ToggleOpen = 1
let Tlist_WinWidth = 50

function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.js,*.hs,*.hpp call UpdateTags()

set backspace=indent,eol,start

scriptencoding utf-8
set encoding=utf-8

" map switching tabs
map <C-PageUp> :tabnext
map <C-PageDown> :tabprev

" make make
nnoremap <F9> :make!<cr><cr>
" nerdtree
map <F4> :NERDTreeToggle<CR>

if filereadable(".vimrc.local")
  source .vimrc.local
endif
