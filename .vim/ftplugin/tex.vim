setlocal nocompatible

"set filetype=tex

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal spell spelllang=en_us

if filereadable(".vimrc.local") && getcwd() != $HOME
  source .vimrc
endif
