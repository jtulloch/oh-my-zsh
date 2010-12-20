autoload colors; colors

for COLOR in RED GREEN BLUE YELLOW WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

PR_RESET="%{${reset_color}%}";

PROMPT='$(get_prompt)'
RPROMPT='$(get_right_prompt)'

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="(" 
ZSH_THEME_GIT_PROMPT_SUFFIX="${PR_CYAN})${PR_RESET}" 
ZSH_THEME_GIT_PROMPT_DIRTY="${PR_RED}*${PR_RESET}"
ZSH_THEME_GIT_PROMPT_CLEAN="" 
