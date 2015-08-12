setlocal nocompatible

setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal expandtab

if filereadable(".vimrc.local") && getcwd() != $HOME
  source .vimrc.local
endif
