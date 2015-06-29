# avit-mod ZSH Theme

function _user_host() {
    if [[ -n $SSH_CONNECTION ]]; then
        me="%n@%m"
    elif [[ $LOGNAME != $USER ]]; then
        me="%n"
    fi
    if [[ -n $me ]]; then
        echo "%{$fg[cyan]%}$me%{$reset_color%} "
    fi
}

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{${reset_color}%}"

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Get the last commit.
        last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
        # Only proceed if there is actually a commit.
        if [[ $? == 0 && -n $last_commit ]]; then
            now=$(date +%s)
            seconds_since_last_commit=$((now - last_commit))

            # Totals
            minutes=$((seconds_since_last_commit / 60))
            hours=$((seconds_since_last_commit / 3600))

            # Sub-hours and sub-minutes
            days=$((seconds_since_last_commit / 86400))
            sub_hours=$((hours % 24))
            sub_minutes=$((minutes % 60))

            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then
                    color="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$MINUTES" -gt 10 ]; then
                    color="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    color="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                color="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ $hours -gt 24 ]; then
                commit_age="${days}d"
            elif [ $minutes -gt 60 ]; then
                commit_age="${sub_hours}h${sub_minutes}m"
            else
                commit_age="${minutes}m"
            fi

            echo " $color$commit_age%{$reset_color%}"
        fi
    fi
}

if [[ $USER == "root" ]]; then
    CARETCOLOR="red"
else
    CARETCOLOR="white"
fi

MODE_INDICATOR="%{$fg_bold[yellow]%}❮%{$reset_color%}%{$fg[yellow]%}❮❮%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}✹ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➜ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[magenta]%}◒ "

ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg[cyan]%} ▴"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg[magenta]%} ▾"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg[red]%} ↕"

ZSH_THEME_VIRTUALENV_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_VIRTUALENV_SUFFIX="› %{$reset_color%}"

ZSH_THEME_RVM_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_RVM_PROMPT_SUFFIX="› %{$reset_color%}"

local _user='$(_user_host)'
local _wd="%{$fg[blue]%}%5~%{$reset_color%} "
local _ruby='$(ruby_prompt_info)'
local _venv='$(virtualenv_prompt_info)'
local _git='$(git_prompt_info)'

local _gstatus='$(git_prompt_status)'
local _gremote='$(git_remote_status)$(git_commits_ahead)'
local _gtime='$(_git_time_since_commit)'

local _vi='$(vi_mode_prompt_info)'

local _jobs="%{$fg[cyan]%}%(1j. ⚙ %j.)%{$reset_color%}"
local _return="%{$fg[red]%}%(?..↵ %?)%{$reset_color%}"

PROMPT="╭─${_user}${_wd}${_venv}${_ruby}${_git}${_gstatus}${_gremote}${_gtime}${_vi}
╰─▶ "
PROMPT2="  ▶ "
RPROMPT="${_return}${_jobs}"

