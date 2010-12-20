
ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$reset_color%}"

export PS1='[%{${fg[green]}%}%n%{${fg[white]}%}@%M: %{${fg[yellow]}%}%1d%{${fg[white]}%}$(git_prompt_info)] '
setopt prompt_subst

