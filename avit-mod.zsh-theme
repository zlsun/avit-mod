# AVIT ZSH Theme

local current_dir="%{$fg[blue]%}%3~%{$reset_color%} "

function _user_host() {
    if [[ -n $SSH_CONNECTION ]]; then
        me="%n@%m"
    elif [[ $LOGNAME != $USER ]]; then
        me="%n"
    fi
    if [[ -n $me ]]; then
        echo "%{$fg[cyan]%}$me%{$reset_color%}:"
    fi
}
local user_host='$(_user_host)'

function _vi_status() {
    if {echo $fpath | grep -q "plugins/vi-mode"}; then
        echo "$(vi_mode_prompt_info)"
    fi
}
local vi_status='$(_vi_status)'

function _ruby_version() {
    if {echo $fpath | grep -q "plugins/rvm"}; then
        echo "%{$fg[grey]%}$(rvm_prompt_info)%{$reset_color%}"
    fi
}
local ruby_version='$(_ruby_version)'

# Colors vary depending on time lapsed.
ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{%}"

# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function _git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=$(git log --pretty=format:'%at' -1 2> /dev/null)
            now=$(date +%s)
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            minutes=$((seconds_since_last_commit / 60))
            hours=$((seconds_since_last_commit/3600))

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

            echo "$color$commit_age%{$reset_color%}"
        fi
    fi
}
local git_time='$(_git_time_since_commit)'

local git_info='$(git_prompt_info)%{$reset_color%}'
local git_status='$(git_prompt_status)'

local up='$(echotc UP 1)'
local down='$(echotc DO 1)'

local return_status="%{$fg[red]%}%(?..⍉%?)%{$reset_color%}"
local hist_no="%{$fg[grey]%}%h%{$reset_color%}"

PROMPT="╭─${user_host}${current_dir} ${git_info} ${ruby_version}
╰─▶ "
PROMPT2="%{$fg[grey]%}◀%{$reset_color%} "
RPROMPT="%{${up}%}${vi_status} ${git_time} ${git_status} ${return_status}%{${down}%}"

if [[ $USER == "root" ]]; then
    CARETCOLOR="red"
else
    CARETCOLOR="white"
fi

MODE_INDICATOR="%{$fg_bold[yellow]%}❮%{$reset_color%}%{$fg[yellow]%}❮❮%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}✚ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚑ "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}▴ "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[cyan]%}§ "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{%}◒ "

