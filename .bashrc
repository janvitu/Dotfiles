# ==================================================================
# SOURCE
# ==================================================================

# ==================================================================
# PROMPT
# ==================================================================

# TURN OFF ZSH NOTIFICATIONS
export BASH_SILENCE_DEPRECATION_WARNING=1

# GIT BRANCH
parse_git_branch() {
    gitstatus=`git status 2> /dev/null`
    if [[ `echo $gitstatus | grep "Changes to be committed"` != "" ]] 
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1 ↑]/'
    elif [[ `echo $gitstatus | grep "Changes not staged for commit"` != "" ]] 
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1 #]/'
    elif [[ `echo $gitstatus | grep "Untracked"` != "" ]] 
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1 ✘]/'
    elif [[ `echo $gitstatus | grep "Your branch is ahead of"` != "" ]]
    then
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1 →]/'
    elif [[ `echo $gitstatus | grep "nothing to commit"` != "" ]] 
    then
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
    else
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1 ?]/'
    fi
}

# SYMBOLS
WORKING_DIRECTORY="\W"
PROMPT_SYMBOL="\$"

# FORMATTING
NEWLINE="\n"

# COLOR
COLOR_USER_CURRENT_STATE='\[$(tput setaf 69)\]'
COLOR_STATEMENT='\[$(tput setaf 69)\]'
GIT_COLOR='\[$(tput setaf 1)\]'
COLOR_RESET='\[\033[0m\]'
if [ $(id -u) = 0 ]; then
   export PS1="%{COLOR_USER_CURRENT_STATE}[root]@%WORKING_DIRECTORY${COLOR_STATEMENT}${GIT_COLOR}\$(parse_git_branch)${COLOR_STATEMENT}$PROMPT_SYMBOL${COLOR_RESET} "
else
   export PS1="${COLOR_USER_CURRENT_STATE}$WORKING_DIRECTORY${COLOR_STATEMENT}${GIT_COLOR}\$(parse_git_branch)${COLOR_STATEMENT}$PROMPT_SYMBOL${COLOR_RESET} "
fi
# RENDER
export VIMCONFIG=~/.vim
#export PS1="export PS1="${COLOR_USER_CURRENT_STATE}$WORKING_DIRECTORY${COLOR_STATEMENT}${GIT_COLOR}\$(parse_git_branch)${COLOR_STATEMENT}$PROMPT_SYMBOL${COLOR_RESET} "
