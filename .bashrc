### ASCII ART :)

### Ativar o Cope ####

#PATH=/usr/share/perl5/vendor_perl/auto/share/dist/Cope:$PATH

##### ALIASES #####

# CORES CUSTOMIZADAS NO LS
eval $( dircolors -b $HOME/.dircolors)

# COMANDOS MODIFICADOS

alias diff='colordiff'
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias ping='ping -c 5'
alias ..='cd ..'
alias ls='ls++ --potsf'

# SEGURANÇA
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' vai perguntar pra cada arquivo
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# complete
complete -cf sudo
complete -cf man

export HISTCONTROL=ignoreboth


# vimbrant-like colours in the Linux console (tty)

# linux console colors (vimbrant)
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0000000" #black
    echo -en "\e]P8505354" #darkgrey
    echo -en "\e]P1f92672" #darkred
    echo -en "\e]P9ff5995" #red
    echo -en "\e]P282b414" #darkgreen
    echo -en "\e]PAb6e354" #green
    echo -en "\e]P3fd971f" #brown
    echo -en "\e]PBfeed6c" #yellow
    echo -en "\e]P456c2d6" #darkblue
    echo -en "\e]PC8cedff" #blue
    echo -en "\e]P58c54fe" #darkmagenta
    echo -en "\e]PD9e6ffe" #magenta
    echo -en "\e]P6465457" #darkcyan
    echo -en "\e]PE899ca1" #cyan
    echo -en "\e]P7ccccc6" #lightgrey
    echo -en "\e]PFf8f8f2" #white
    clear # bring us back to default input colours
fi
clear

#### PS1 ####

bash_prompt_command() {
    # Quantos caracteres o $PWD deve mostrar
    local maxtam=25
    # Mostra que p diretorio foi truncado
    local trunc=".."
    local dir=${PWD##*/}
    maxtam=$(( ( maxtam < ${#dir} ) ? ${#dir} : maxtam ))
    NEW_PWD=${PWD/#$HOME/\~}
    local pwdoffset=$(( ${#NEW_PWD} - maxtam ))
    if [ ${pwdoffset} -gt "0" ]
    then
        NEW_PWD=${NEW_PWD:$pwdoffset:$maxtam}
        NEW_PWD=${trunc}/${NEW_PWD#*/}
    fi
}
bash_prompt() {
    case $TERM in
     xterm*|rxvt*)
         local BARRATITULO='\[\033]0;\u:${NEW_PWD}\007\]'
          ;;
     *)
         local BARRATITULO=""
          ;;
    esac
    
    #CORES - COPYCOLADA DO WIKI DO ARCH
    
    local NONE="\[\033[0m\]"    # unsets color to term's fg color
    
    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white
    
    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"
    
    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"
    
    local UC=$W                 # COR DO USER
    [ $UID -eq "0" ] && UC=$R   # COR DO ROOT
    
    PS1="$BARRATITULO ${UC}┌─${EMK}[${UC}\u${EMK}@${UC}\h ${EMB}\${NEW_PWD}${EMK}]\n ${UC}└── ${UC}\\$ ${NONE}"
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt
