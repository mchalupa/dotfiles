# The following lines were added by compinstall
zstyle :compinstall filename '/home/marek/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

bindkey -e
# End of lines configured by zsh-newuser-install

# aliases
alias xterm='xterm -bg black -fg white'
alias ls='ls --color=auto'
alias wenv='export WAYLAND_ENV=1; cd /home/marek/sources; ./wayland-build.sh env'
alias i3lock='i3lock -c 000000'
alias dsh='jhbuild shell'
alias gsw='jhbuild run dbus-launch gnome-session --session=gnome-wayland'
alias gswp="pgrep -a gnome-shell | grep /home/marek/local/bin/gnome-shell | cut -d ' ' -f 1"

#prompt
autoload -U colors && colors
source ~/.git-prompt.sh

PROMPT="%{$fg_bold[green]%}%n@%m%{$reset_color%} %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%# "
# RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

# set git prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto"
#setopt PROMPT_SUBST ; PS1='%{$fg[gray]%}$(__git_ps1 "(%s) ")%{$reset_color%}%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%# '

# RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
setopt PROMPT_SUBST ; RPROMPT='%{$fg[gray]%}$(__git_ps1 "(%s) ")%{$reset_color%}[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]'



if [ "$WAYLAND_ENV" = 1 ]; then
	PROMPT="[Wl] $PROMPT"
fi

if [ -n "$JHBUILD_PREFIX" ]; then
	PROMPT="[jh] $PROMPT"
fi



if [ -f /usr/bin/color-gcc -o -f /bin/color-gcc ]; then
	alias gcc=color-gcc
fi

# wrapper for bindkey
function bk()
{
	if [ "$#" = "0" ]; then
		bindkey
	elif [ "$1" = "-v" ]; then
		echo "Vim mode"
		bindkey -v
	elif [ "$1" = "-e" ]; then
		echo "Emacs mode"
		bindkey -e
	else
		bindkey "$1"
	fi
}

# set bindkey -v (Vim mode)
#bk -v

# print welcome message
uname -srn
date
echo -e "--------------------------------------------------\n"

# ##############################################################################
# key bindings
# ##############################################################################
bindkey "[1~" beginning-of-line
bindkey "^[[4~" end-of-line

typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
           printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
            printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

export LC_ALL=C
export LANG=C

export CFLAGS='-Wall -Wextra -g'

export EDITOR=vim
export PATH="$HOME/.local/bin:$PATH"
