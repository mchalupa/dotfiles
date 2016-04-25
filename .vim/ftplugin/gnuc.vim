setlocal nocompatible

set filetype=c

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

if filereadable(".vimrc.local") && getcwd() != $HOME
  source .vimrc
endif
