setlocal nocompatible

setlocal softtabstop=4
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab

if filereadable(".vimrc") && getcwd() != $HOME
  source .vimrc
endif
