#============================================================
#
#= Config Values
#= SET THESE VALUES TO ENSURE YOUR ALIASES WORK CORRECTLY
#	Set your CWSPATH variable to your CWS folder's path.
#
#============================================================
CWSPATH=~/Jobvite/CWS/
#============================================================

#============================================================
#
#  Global Variables
#	Variables for the current branch, and its path.
#
#============================================================
BRANCH=$(git branch |grep \* | cut -d " " -f2)
BRANCHPATH=$CWSPATH/$BRANCH/
#============================================================

#============================================================
#
#  GITHUB ALIASES AND FUNCTIONS
#
#============================================================
function addkick() {
	pushd $PWD && mkdir $@/styles && $@/styles && git init && git remote add kickoff https://github.com/jobvite-github/Kickoff.git && git fetch kickoff && git checkout kickoff/master && rm -rf .git && popd
}
function camp() {
    # Usage
    #= camp
    #= camp <commit_msg>
    #= camp -t <tag>
    #= camp -t <tag> <commit_msg>
    #= camp -t <tag> -m <msg>
    #= camp -t <tag> -m <msg> <commit_msg>
    #
    # You can specify a branch name by adding that branch name at
    #    the end of the function call. Example:
    #        camp <commit_msg> <branch_name>
    #-------------------------------------------------------------
    local branch=$(git branch |grep \* | cut -d " " -f2)

    # Flags
    m=false		#commit message flag
    t=false		#Includes tag
    tm=false	#tag message flag
    f=false		#forced flag
    # Messages / Tag
    tag=""
    msg=""		#commit message
    tmg=""		#tag message

    for (( i = 1; i <= $#; i += 1 )); do
        if [[ ${@[$i]} == '-t' ]] then # if tagged
            t=true
            i+=1
            tag=${@[$i]}
        elif [[ ${@[$i]} == '-m' ]] then # if tag and commit msg
            tm=true
            i+=1
            tmg=${@[$i]}
        elif [[ ${@[$i]} == '-f' ]] then # if force pushed
            f=true
        elif [[ ${@[$i]} != "" ]] then
            git show-ref --quiet refs/remotes/origin/${@[$i]}

            if [[ $? == 0 ]] then # if last parameter is specified branch
                branch=${@[$i]}
            else # if it isn't a flag or a branch, it must be a commit message
                m=true
                msg=${@[$i]}
            fi
        fi
    done

    if ( $m ) then
    else
        m=true
        msg=$tmg
    fi

    # echo '------ tags -------'
    # echo 'm: ' $m
    # echo 't: ' $t
    # echo 'tm: ' $tm
    # echo 'f: ' $f
    # echo
    # echo '------ info -------'
    # echo 'tag: ' $tag
    # echo 'tmg: ' $tmg
    # echo 'msg: ' $msg
    # echo 'branch: ' $branch

    git add .

    git commit -m $msg

	if ( $f ) then
		git push origin $branch -f
	else
		git push origin $branch
	fi

    if ( $t ) then
        git tag -a $tag -m $tmg
        git push origin --tags
    fi
}
function cmp() {
    if [[ $1 != "" ]]
    then
        git commit -m $1
    else
        # empty camp sets origin to origin/current_branch
        git push -u origin $(git symbolic-ref --short HEAD) $2
    fi
    git push $2
}
function gwtn() {
    if [[ $1 != "" ]] then
        git show-ref --quiet refs/remotes/origin/${1}
        if [[ $? == 0 ]] then
            $CWSPATH && git checkout starter_branch && git fetch && git pull && git worktree add --track -B ${1} ./${1} origin/${1} && git checkout root && ${1}/ && mkdir _dev && git push --set-upstream origin ${1} && styles/ && npm i && .. && code .
        else
            $CWSPATH && git checkout starter_branch && git fetch && git pull && git worktree add ${1} && git checkout root && ${1}/ && mkdir _dev && styles/ && npm i && .. && git commit -am "Setting up $1" && git push --set-upstream origin ${1} && code .
        fi
    else
        echo 'Add a worktree name ( e.x. gwtn myworktree )'
    fi
}
function gwtr() {
	branchExists=1
	local branch=$(git branch |grep \* | cut -d " " -f2)

	if [[ $1 != "" ]] then
		branch=$1
	elif [[ $branch == "root" ]] || [[ $branch == "starter_branch" ]] then
		echo "You can't use gwtr in root or starter_branch. Either specify a branch, or cd into that branch and run gwtr"
		return 1
    fi

	$CWSPATH && $branch

	git show-ref --quiet refs/remotes/origin/$branch

	if [[ $? == 0 ]] then # if last parameter is specified branch
		git push origin --delete $branch
	fi

	$CWSPATH
	git worktree remove $branch
	git branch -D $branch
}
function gwtm() {
    if [[ $1 != "" ]] then
        git show-ref --quiet refs/remotes/origin/${1}
        if [[ $? == 0 ]] then
            $CWSPATH && git checkout starter_branch && git fetch && git pull && git worktree add --track -B ${1} ./${1} origin/${1} && git checkout root && ${1}/ && mkdir _dev && git push --set-upstream origin ${1}
        else
            $CWSPATH && git checkout starter_branch && git fetch && git pull && git worktree add ${1} && git checkout root && ${1}/ && mkdir _dev && git commit -am "Setting up $1" && git push --set-upstream origin ${1}
        fi
    else
        echo 'Add a worktree name ( e.x. gwtm myworktree )'
    fi
}
function new() {
    if [ -d desktop/ ] || mkdir desktop && touch desktop/.gitkeep
    if [ -d mobile/ ] || mkdir mobile && touch mobile/.gitkeep
    if [ -d images/ ] || mkdir images && touch images/.gitkeep
    if [ -d styles/ ] || addkick
}
function start() {
    if [[ $1 != "" ]]
    then
        $BRANCH/${@}/**/styles && npm i && gulp
    else
        if [ -d $BRANCH/styles/ ]
        then
            $BRANCH/styles/ && npm i && gulp
        elif [ -d $BRANCH/**/styles/ ]
        then
            $BRANCH/**/styles/ && npm i && gulp
        elif [ -d $BRANCH/style/ ]
        then
            $BRANCH/style/ && npm i && gulp
        elif [ -d $BRANCH/**/style/ ]
        then
            $BRANCH/**/style/ && npm i && gulp
        else
            echo 'No styles or style folder found in the parent directory'
        fi
    fi
}
function stats() {
    git log --stat --all --pretty=format:"%C(red bold)%h%Creset -%C(auto)%d%Creset %s%Creset - %C(green bold)%an %C(green dim)(%cr)" ${1-\-50}
}

# Tagging
function tagging() {
	if [[ $1 == "-D" ]] then
		git tag -d $2
		git push --delete origin $2
		return 1
	elif [[ $1 != "" ]] then
		git tag -a $1 -m "Updating to ${1}"
		git push origin $1
		return 1
	else
		echo 'Add a version ( e.x. tagging v1.0 )'
    fi
}
alias tag='git tag'
alias tags='git tag -l'
alias tug='git pull'
#End Tagging

#-------------------------------------------------------------
# GitHub Aliases
#-------------------------------------------------------------
alias add='git add'
alias back='git reset HEAD~1'
alias bkto='git reset --hard origin/$(git symbolic-ref --short HEAD)'
alias branch='git branch'
alias branches='git branch --list'
alias bset='git branch --set-upstream-to=origin/$(git symbolic-ref --short HEAD) $(git symbolic-ref --short HEAD)'
alias cam='git add . && git commit -m'
alias ch='git checkout'
alias chr='git checkout root'
alias chsb='git checkout starter_branch'
alias clone='git clone'
alias cm='git commit -m'
alias coressh='git config core.sshCommand "ssh -i ~/.ssh/${1} -F /dev/null"'
alias counts='git shortlog -sne'
alias dm='git diff --minimal'
alias fetch='git fetch'
alias fuck='reset --hard origin/$(git symbolic-ref --short HEAD)'
alias grs='git reset'
alias grsurl='git remote set-url origin'
alias grv='git remote -v'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtl='git worktree list'
alias gwtrm='git worktree remove'
alias lga='git log --graph --all --pretty=format:"%C(red bold)%h%Creset -%C(auto)%d%Creset %s%Creset - %C(green bold)%an %C(green dim)(%cr)"'
alias mg='git merge'
alias newb='git checkout -b'
alias peek='git log --graph $(git symbolic-ref --short HEAD) --pretty=format:"%C(red bold)%h%Creset -%C(auto)%d%Creset %s%Creset - %C(green bold)%an %C(green dim)(%cr)" ${1-\-20}'
alias peekall='git log --graph origin --pretty=format:"%C(red bold)%h%Creset -%C(auto)%d%Creset %s%Creset - %C(green bold)%an %C(green dim)(%cr)" ${1-\-20}'
alias poke='git push origin $(git symbolic-ref --short HEAD)'
alias pop='git stash pop'
alias pset='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias ptag='git push origin --tags'
alias pull='git pull'
alias push='git push'
alias pushall='git push && git push origin --tags'
alias rb='git rebase'
alias ref='git reflog'
alias s='git status'
alias setit='git reset --hard origin/$(git symbolic-ref --short HEAD)'
alias shit='git checkout .'
alias shove='git push -f'
alias sta='git add . && git stash'
alias stash='git add . && git stash'
alias stashed='git stash show'
alias tag='git tag'
alias tags='git tag -l'
alias tug='git pull'
alias whichup=whichupstream='git branch -vv'

#-------------------------------------------------------------
# NPM
#-------------------------------------------------------------
alias naf='npm audit fix'
alias ncui='ncu -u && npm install'
alias ncuif='ncu -u && npm install && npm audit fix'

#-------------------------------------------------------------
#
#  GREETING, MOTD, ETC. ...
#
#  Color definitions (taken from Color Bash Prompt HowTo).
#  Some colors might look different of some terminals.
#  For example, I see 'Bold Red' as 'orange' on my screen,
#  hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.
#
#-------------------------------------------------------------

# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

#============================================================
#
#  ALIASES AND FUNCTIONS
#
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
#+ be converted into scripts and removed from here.
#
#============================================================

#-------------------
# Personnal Aliases
#-------------------
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p' # -> Prevents accidentally clobbering files.
alias which='type -a'
alias ..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------
# Add colors for filetype and  human-readable sizes by default on 'ls':
# alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

#-------------------------------------------------------------
# Load / Edit .profile
#-------------------------------------------------------------
alias config='code ~/.profile && echo "$(tput setaf 255)$(tput setab 9)Editing ~/.profile"'
alias ebash='code ~/.profile && echo "$(tput setaf 255)$(tput setab 9)Editing ~/.profile"'
alias reload='source ~/.profile && echo "$(tput setaf 41).profile Reloaded"'
alias sbash='source ~/.profile && echo "$(tput setaf 41).profile Reloaded"'

# System Stuff
alias ding='print \\a'

# The 'ls' family
alias lsa='ls -a'
