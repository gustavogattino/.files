#{{{ ALIAS
# Modified Commands
alias diff='colordiff'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias ..='cd ..'
alias ls='ls --color=auto'
alias ls=' ls -C -F -h --color=always'
alias vi='vim'

# Security
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' vai perguntar pra cada arquivo
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# New Commands
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias :q='exit'

# Corrections
setopt correct_all
alias man='nocorrect man'
alias mv='nocorrect mv'
alias mkdir='nocorrect mkdir'
alias sudo='nocorrect sudo'

# LOL
alias wtf='dmesg'
alias onoz='cat /var/log/errors.log'
alias rtfm='man'
alias :3='echo'
alias moar='more'
alias tldr='less'
alias alwayz='tail -f'
alias icanhas='mkdir'
alias gimmeh='touch'
alias donotwant='rm'
alias dowant='cp'
alias gtfo='mv'
alias nowai='chmod'
alias hai='cd'
alias nomz='ps aux'
alias nomnom='killall'
alias byes='exit'
alias cya='reboot'
alias kthxbai='halt'
#}}}




#{{{ UTILS
# Arch Linux
if [[ -x `which packer` ]]; then
  upgrade () {
    packer -Syu
  }
fi

pacmanallkeys() {
  # Get all keys for developers and trusted users
  curl https://www.archlinux.org/{developers,trustedusers}/ |
  awk -F\" '(/pgp.mit.edu/) {sub(/.*search=0x/,"");print $1}' |
  xargs sudo pacman-key --recv-keys
}

alias paclistaorfaos='sudo pacman -Qdt'
alias pacremoveorfaos='sudo pacman -Rs $(pacman -Qtdq)'


# man
man() {
      env \
      	  LESS_TERMCAP_mb=$(printf "\e[1;31m") \
	  LESS_TERMCAP_md=$(printf "\e[1;31m") \
	  LESS_TERMCAP_me=$(printf "\e[0m") \
	  LESS_TERMCAP_se=$(printf "\e[0m") \
	  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
	  LESS_TERMCAP_ue=$(printf "\e[0m") \
	  LESS_TERMCAP_us=$(printf "\e[1;32m") \
	  			   man "$@"
}

# extract
function extract() {
  local remove_archive
  local success
  local file_name
  local extract_dir

  if (( $# == 0 )); then
    echo "Usage: extract [-option] [file ...]"
    echo
    echo Options:
    echo "    -r, --remove    Remove archive."
    echo
    echo "Report bugs to <sorin.ionescu@gmail.com>."
  fi

  remove_archive=1
  if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
    remove_archive=0 
    shift
  fi

  while (( $# > 0 )); do
    if [[ ! -f "$1" ]]; then
      echo "extract: '$1' is not a valid file" 1>&2
      shift
      continue
    fi

    success=0
    file_name="$( basename "$1" )"
    extract_dir="$( echo "$file_name" | sed "s/\.${1##*.}//g" )"
    case "$1" in
      (*.tar.gz|*.tgz) tar xvzf "$1" ;;
      (*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
      (*.tar.xz|*.txz) tar --xz --help &> /dev/null \
        && tar --xz -xvf "$1" \
        || xzcat "$1" | tar xvf - ;;
      (*.tar.zma|*.tlz) tar --lzma --help &> /dev/null \
        && tar --lzma -xvf "$1" \
        || lzcat "$1" | tar xvf - ;;
      (*.tar) tar xvf "$1" ;;
      (*.gz) gunzip "$1" ;;
      (*.bz2) bunzip2 "$1" ;;
      (*.xz) unxz "$1" ;;
      (*.lzma) unlzma "$1" ;;
      (*.Z) uncompress "$1" ;;
      (*.zip) unzip "$1" -d $extract_dir ;;
      (*.rar) unrar x -ad "$1" ;;
      (*.7z) 7za x "$1" ;;
      (*.deb)
        mkdir -p "$extract_dir/control"
        mkdir -p "$extract_dir/data"
        cd "$extract_dir"; ar vx "../${1}" > /dev/null
        cd control; tar xzvf ../control.tar.gz
        cd ../data; tar xzvf ../data.tar.gz
        cd ..; rm *.tar.gz debian-binary
        cd ..
      ;;
      (*) 
        echo "extract: '$1' cannot be extracted" 1>&2
        success=1 
      ;; 
    esac

    (( success = $success > 0 ? $success : $? ))
    (( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
    shift
  done
}

# Nyan cat
if [[ -x `which nc` ]]; then
  alias nyan='nc -v miku.acm.uiuc.edu 23' # nyan cat
fi
#}}}




#{{{ HISTORY
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

setopt share_history # share command history data
setopt append_history
setopt extended_history
setopt hist_no_store
setopt hist_ignore_all_dups # ignore duplication command history list
setopt hist_ignore_space

setopt hist_expire_dups_first
setopt hist_verify
setopt inc_append_history
#}}}



#{{{ COMPLETION
# Command completion
# load completions system
zmodload -i zsh/complist

# auto rehash commands
# http://www.zsh.org/mla/users/2011/msg00531.html
zstyle ':completion:*' rehash true

# for all completions: menuselection
zstyle ':completion:*' menu select=1

# for all completions: grouping the output
zstyle ':completion:*' group-name ''

# for all completions: color
eval $( dircolors -b $HOME/.dircolors )
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# fault tolerance
zstyle ':completion:*' completer _complete _correct _approximate
# (1 error on 3 characters)
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

# case-insensitive (all),partial-word and then substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# for all completions: show comments when present
zstyle ':completion:*' verbose yes

# kill: advanced kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) #([a-z]#) #([0-9a-z-]#) *=01;31=01;37=01;35'
zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,user,cmd'

# rm: advanced completion (e.g. bak files first)
zstyle ':completion::*:rm:*:*' file-patterns '*.o:object-files:object\ file *(~|.(old|bak|BAK)):backup-files:backup\ files *~*(~|.(o|old|bak|BAK)):all-files:all\ files'

# vi: advanced completion (e.g. tex and rc files first)
zstyle ':completion::*:vi:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'

# command not found hook
source /usr/share/doc/pkgfile/command-not-found.zsh

autoload -Uz compinit && compinit
#}}}



#{{{ Key bindings
# make search up and down work, so partially type and hit up/down to find relevant stuff
#pageup & pagedown
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
#up & down
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey "^[[7~" beginning-of-line
bindkey "^[[8~"  end-of-line

bindkey "^[[H" beginning-of-line
bindkey "^[[F"  end-of-line

bindkey "^[Oc" forward-word
bindkey "^[Od" backward-word

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

bindkey "^[[3~" delete-char
bindkey "^[[3^" delete-word
bindkey "^H" backward-delete-word
bindkey "^[[3;5~" delete-word
bindkey "^[[3;3~" delete-word
# }}}



#{{{ EYECANDY
# Terminal Title
function title {
  if [[ "$EMACS" == *term* ]]; then
    return
  fi
  if [[ "$TERM" == screen* ]]; then
    print -Pn "\ek$1:q\e\\" #set screen hardstatus, usually truncated at 20 chars
  elif [[ "$TERM" == xterm* ]] || [[ $TERM == rxvt* ]] || [[ $TERM == ansi ]] || [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    print -Pn "\e]2;$2:q\a" #set window name
    print -Pn "\e]1;$1:q\a" #set icon (=tab) name (will override window name on broken terminal)
  fi
}

ZSH_THEME_TERM_TAB_TITLE_IDLE="%15<..<%~%<<" #15 char left truncated PWD
ZSH_THEME_TERM_TITLE_IDLE="%n@%m: %~"

#Appears when you have the prompt
function omz_termsupport_precmd {
  title $ZSH_THEME_TERM_TAB_TITLE_IDLE $ZSH_THEME_TERM_TITLE_IDLE
}

#Appears at the beginning of (and during) of command execution
function omz_termsupport_preexec {
  emulate -L zsh
  setopt extended_glob
  local CMD=${1[(wr)^(*=*|sudo|ssh|rake|-*)]} #cmd name only, or if this is sudo or ssh, the next cmd
  title "$CMD" "%100>...>${2:gs/%/%%}%<<"
}

autoload -U add-zsh-hook
add-zsh-hook precmd  omz_termsupport_precmd
add-zsh-hook preexec omz_termsupport_preexec

# Prompt
# color
autoload -U colors && colors

# Custom colors
local c1=$( printf "\e[38;5;245m")
local c2=$( printf "\e[38;5;250m")
local c3=$( printf "\e[38;5;197m")


function precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))
   
    PR_FILLBAR=""
    PR_PWDLEN=""
    
    local promptsize=${#${(%):----%n@%m--------}}
    local pwdsize=${#${(%):-%~}}
    
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
	PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..─.)}"
    fi
}

preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}

setprompt () {
    setopt prompt_subst

    PROMPT='
 %{$fg[white]%}┌╼ %{$c1%}%(!.%SROOT%s.%n)%{$c3%}@%{$c2%}%m %{$fg[white]%}╾╼ %{$fg_no_bold[yellow]%}%$PR_PWDLEN<...<%~%<< %{$fg_no_bold[white]%}╾${(e)PR_FILLBAR}┐
 └─╼ %{$reset_color%}'
    RPROMPT='%{$fg[white]%}─ %{$fg_no_bold[green]%}%D{%H:%M} %{$fg[white]%}╾┘%{$reset_color%}'
    PS2='%{$fg[white]%} └─╼ %{$reset_color%}'
}

if [ "$TERM" = "linux" ]; then
PROMPT='
%n@%m '
 else
 
 setprompt
 
 fi
 
#}}}

#{{{ HIGHLIGHT
source /home/sauron/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=none'
ZSH_HIGHLIGHT_STYLES[alias]='fg=white'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=white'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
ZSH_HIGHLIGHT_STYLES[command]='fg=white'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=red'
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=magenta,bold'
#}}}
