" need to enable by:
" :filetype plugin on
setlocal nocompatible

setlocal ts=8 sts=8 st=8 sw=8
setlocal noexpandtab

if filereadable(".vimrc") && getcwd() != $HOME
  source .vimrc
endif
