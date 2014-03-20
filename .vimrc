syntax on
se nu
set autoindent
set hlsearch
colorscheme aldmeris

" autocmd Filetype cpp setlocal ts=4 sts=4 sw=4
" autocmd Filetype h setlocal ts=4 sts=4 sw=4
" autocmd Filetype java setlocal ts=4 sts=4 sw=4 et
:filetype plugin on

command Gnu setlocal ts=2 sts=2 sw=2 et
"
" set ctags
set tags=./tags;/

augroup filetype
      au! BufRead,BufNewFile *.ll     set filetype=llvm
      au! BufRead,BufNewFile *.llvm   set filetype=llvm
      au! BufRead,BufNewFile *.cpp    set filetype=cpp
augroup END

" It's VIM, not VI
setlocal nocompatible

" Highlight trailing whitespace and lines longer than 80 columns.
"highlight LongLine ctermbg=DarkYellow guibg=DarkYellow
highlight LongLine ctermbg=Red guibg=Red
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
if v:version >= 702
  " Lines longer than 80 columns.
  au BufWinEnter * let w:m0=matchadd('LongLine', '\%>80v.\+', -1)

  " Whitespace at the end of a line. This little dance suppresses
  " whitespace that has just been typed.
  au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
  au InsertEnter * call matchdelete(w:m1)
  au InsertEnter * let w:m2=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
  au InsertLeave * call matchdelete(w:m2)
  au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
else
  au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
  au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
  au InsertLeave * syntax match WhitespaceEOL /\s\+$/
endif

" if filereadable(".vimrc") && getcwd() != $HOME
"   source .vimrc
" endif
