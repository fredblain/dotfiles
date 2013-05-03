# /etc/zsh/zshrc ou ~/.zshrc
# Fichier de configuration principal de zsh, lu au lancement des shells interactifs
# (et non des shells d'interprétation de fichier)
# Formation Debian GNU/Linux par Alexis de Lattre
# http://formation-debian.via.ecp.fr/

################
# 1. Les alias #
################


# Gestion du 'ls' : couleur & ne touche pas aux accents
alias rm='rm -i'

# Raccourcis pour 'ls'
alias ls='ls -BG'
alias ll='ls -BGgrtlh'
alias la='ls -a'
alias lla='ls -la'

# Quelques alias pratiques
alias .='pwd'
alias ..='cd ..'

# VIM & GVIM
alias vi='mvim'
alias vim='mvim'
# --------------------

alias h='history'
#alias c='clear'
alias less='less --quiet'
alias df='df -h'
alias du='du -h'
#alias m='mutt -y'
alias clr='clear ; pwd ; ll -gG'
alias cll='clear ; pwd ; ll'
alias cls='clear ; pwd ; ls'
alias grep='grep -i --color=auto'
alias vimdiff='vimdiff -R'
alias rm='rm -i'
alias chexec='chmod u+x'


#######################################
# 2. Prompt et définition des touches #
#######################################

# Exemple : ma touche HOME, cf  man termcap, est codifiee K1 (upper left
# key  on keyboard)  dans le  /etc/termcap.  En me  referant a  l'entree
# correspondant a mon terminal (par exemple 'linux') dans ce fichier, je
# lis :  K1=\E[1~, c'est la sequence  de caracteres qui sera  envoyee au
# shell. La commande bindkey dit simplement au shell : a chaque fois que
# tu rencontres telle sequence de caractere, tu dois faire telle action.
# La liste des actions est disponible dans "man zshzle".

# Correspondance touches-fonction
bindkey -e
bindkey ''    beginning-of-line       # Home
bindkey ''    end-of-line             # End
bindkey ''    delete-char             # Del
bindkey "\e[1~" beginning-of-line       # Home
bindkey "\e[2~" overwrite-mode          # Insert
bindkey "\e[3~" delete-char             # Del
bindkey "\e[4~" end-of-line             # End
bindkey "\e[5~" history-search-backward # PgUp
bindkey "\e[6~" history-search-forward  # PgDn
bindkey "5C"    forward-word            # CTRL-Right
bindkey "5D"    backward-word           # CTRL-Left

# Prompt couleur (la couleur n'est pas la même pour le root et
# pour les simples utilisateurs)
if [ "`id -u`" -eq 0 ]; then
  export PS1="%{[36;1m%}%T %{[34m%}%n%{[33m%}@%{[37m%}%m %{[32m%}%~%{[33m%}%#%{[0m%} "
else
  export PS1="%{[36;1m%}%T %{[31m%}%n%{[33m%}@%{[37m%}%m %{[32m%}%~%{[33m%}%#%{[0m%} "
fi

# Prise en charge des touches [début], [fin] et autres
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

[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char


# Titre de la fenêtre d'un xterm
case $TERM in
   xterm*)
       precmd () {print -Pn "\e]0;%n@%m: %~\a"}
       ;;
esac

# Gestion de la couleur pour 'ls' (exportation de LS_COLORS)
if [ -x /usr/bin/dircolors ]
then
  if [ -r ~/.dir_colors ]
  then
    eval "`dircolors ~/.dir_colors`"
  elif [ -r /etc/dir_colors ]
  then
    eval "`dircolors /etc/dir_colors`"
  else
    eval "`dircolors`"
  fi
fi


###########################################
# 3. Options de zsh (cf 'man zshoptions') #
###########################################

# Je ne veux JAMAIS de beeps
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
# >| doit être utilisés pour pouvoir écraser un fichier déjà existant ;
# le fichier ne sera pas écrasé avec '>'
#unsetopt clobber
# Ctrl+D est équivalent à 'logout'
unsetopt ignore_eof
# Affiche le code de sortie si différent de '0'
setopt print_exit_value
# Demande confirmation pour 'rm *'
unsetopt rm_star_silent
# Correction orthographique des commandes
# Désactivé car, contrairement à ce que dit le "man", il essaye de
# corriger les commandes avant de les hasher
setopt correct
# Si on utilise des jokers dans une liste d'arguments, retire les jokers
# qui ne correspondent à rien au lieu de donner une erreur
setopt nullglob

# Schémas de complétion

# - Schéma A :
# 1ère tabulation : complète jusqu'au bout de la partie commune
# 2ème tabulation : propose une liste de choix
# 3ème tabulation : complète avec le 1er item de la liste
# 4ème tabulation : complète avec le 2ème item de la liste, etc...
# -> c'est le schéma de complétion par défaut de zsh.

# Schéma B :
# 1ère tabulation : propose une liste de choix et complète avec le 1er item
#                   de la liste
# 2ème tabulation : complète avec le 2ème item de la liste, etc...
# Si vous voulez ce schéma, décommentez la ligne suivante :
#setopt menu_complete

# Schéma C :
# 1ère tabulation : complète jusqu'au bout de la partie commune et
#                   propose une liste de choix
# 2ème tabulation : complète avec le 1er item de la liste
# 3ème tabulation : complète avec le 2ème item de la liste, etc...
# Ce schéma est le meilleur à mon goût !
# Si vous voulez ce schéma, décommentez la ligne suivante :
#unsetopt list_ambiguous
# (Merci à Youri van Rietschoten de m'avoir donné l'info !)

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effacé
setopt auto_remove_slash
# Ne fait pas de complétion sur les fichiers et répertoires cachés
unsetopt glob_dots

# Traite les liens symboliques comme il faut
setopt chase_links

# Quand l'utilisateur commence sa commande par '!' pour faire de la
# complétion historique, il n'exécute pas la commande immédiatement
# mais il écrit la commande dans le prompt
setopt hist_verify
# Si la commande est invalide mais correspond au nom d'un sous-répertoire
# exécuter 'cd sous-répertoire'
setopt auto_cd
# L'exécution de "cd" met le répertoire d'où l'on vient sur la pile
setopt auto_pushd
# Ignore les doublons dans la pile
setopt pushd_ignore_dups
# N'affiche pas la pile après un "pushd" ou "popd"
setopt pushd_silent
# "pushd" sans argument = "pushd $HOME"
setopt pushd_to_home

# Les jobs qui tournent en tâche de fond sont nicé à '0'
unsetopt bg_nice
# N'envoie pas de "HUP" aux jobs qui tourent quand le shell se ferme
unsetopt hup


###############################################
# 4. Paramètres de l'historique des commandes #
###############################################

# Nombre d'entrées dans l'historique
export HISTORY=20000
export SAVEHIST=20000

# Fichier où est stocké l'historique
export HISTFILE=$HOME/.history

# Ajoute l'historique à la fin de l'ancien fichier
#setopt append_history

# Chaque ligne est ajoutée dans l'historique à mesure qu'elle est tapée
setopt inc_append_history

# Ne stocke pas  une ligne dans l'historique si elle  est identique à la
# précédente
setopt hist_ignore_dups

# Supprime les  répétitions dans le fichier  d'historique, ne conservant
# que la dernière occurrence ajoutée
#setopt hist_ignore_all_dups

# Supprime les  répétitions dans l'historique lorsqu'il  est plein, mais
# pas avant
setopt hist_expire_dups_first

# N'enregistre  pas plus d'une fois  une même ligne, quelles  que soient
# les options fixées pour la session courante
setopt hist_save_no_dups

# La recherche dans  l'historique avec l'éditeur de commandes  de zsh ne
# montre  pas  une même  ligne  plus  d'une fois,  même  si  elle a  été
# enregistrée
setopt hist_find_no_dups


###########################################
# 5. Complétion des options des commandes #
###########################################

zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}'
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion:*' use-compctl false

#autoload -U compinit
#compinit

#autoload -U promptinit
#promptinit
#prompt adam2

precmd ()
{
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))
    PR_FILLBAR=""
    PR_PWDLEN=""

    local promptsize=${#${(%):---( %~ :: %m )---( %D{%H:%M} )---}}
    local pwdsize=${#${(%):-}}

    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
	PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi

    #print dir name in term title
    case $TERM in
	xterm*|rxvt|Eterm)
	print -Pn "\e]0;%n@%m: %~\a"
	;;
    esac
}

setprompt ()
{
    setopt prompt_subst
    autoload colors
    colors

    for color in WHITE RED GREEN YELLOW BLACK BLUE MAGENTA CYAN BLUE; do
	eval $color='%{$termcap[md]$fg[${(L)color}]%}'
	eval LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    DEF="%{$termcap[me]%}"

    typeset -A altchar
    set -A altchar ${(s..)termcap[ac]}
    PR_SET_CHARSET="%{$termcap[eA]%}"
    PR_SHIFT_IN="%{$termcap[as]%}"
    PR_SHIFT_OUT="%{$termcap[ae]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}

    MCOLOR=$CYAN
    PROMPT='$PR_SET_CHARSET\
$BLUE$PR_SHIFT_IN$PR_ULCORNER$BLUE$PR_HBAR$PR_SHIFT_OUT(\
$MCOLOR $WHITE%m$MCOLOR :: $WHITE%~$MCOLOR%$PR_PWDLEN<...<%<<\
$BLUE )$PR_SHIFT_IN$PR_HBAR$BLUE$PR_HBAR${(e)PR_FILLBAR}\
$PR_HBAR$BLUE$PR_HBAR$PR_SHIFT_OUT($WHITE %D{%H:%M} \
$BLUE)$PR_SHIFT_IN$PR_HBAR$BLUE$PR_URCORNER$PR_SHIFT_OUT \
$PR_SHIFT_IN$PR_LLCORNER$BLUE$PR_HBAR$PR_SHIFT_OUT$YELLOW %(!.#.$)$DEF '

    RPROMPT=' $BLUE$PR_SHIFT_IN$PR_HBAR$BLUE$PR_HBAR$PR_SHIFT_OUT\
($MCOLOR%(?,${GREEN}OK,$BLUE$WHITE%139(?,Segfault,\
%130(?,Interrupt,%138(?,Bus Error,%?)))$BLUE KO)\
$BLUE)$PR_SHIFT_IN$PR_HBAR$BLUE$BLUE$PR_LRCORNER$PR_SHIFT_OUT$DEF'

    SPROMPT='zsh: correct $MCOLOR%R$DEF to $MCOLOR%r$DEF%b ? ([${MCOLOR}Y$DEF]es/[${MCOLOR}N$DEF]o/[${MCOLOR}E$DEF]dit/[${MCOLOR}A$DEF]bort) '

    PS2='$RED$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$MCOLOR%_$BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$RED$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$DEF '
}

LISTPROMPT=''
setprompt
