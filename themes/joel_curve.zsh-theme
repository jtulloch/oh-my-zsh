autoload colors; colors

for COLOR in RED GREEN BLUE YELLOW WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

PR_RESET="%{${reset_color}%}";

get_prompt() {
    CURRENTPATH=`pwd`
    if [ "${CURVEPROJECT}" = "" ]; then
        echo "${PR_BLUE}%n@%m${PR_RESET}${PR_CYAN}$(git_prompt_info)${PR_RESET}${PR_YELLOW}->${PR_RESET}"
    else
        BASELOCATION=`basename ${CURRENTPATH}`
        TEMPLOCATION=${CURRENTPATH##${CURVESPACE}/${CURVEPROJECT}}
        CURVEPATH=""
        CURRENTBRANCH=`getCurrentBranch`  
        if [ "${BASELOCATION}" != "" ]; then
            if [ "${BASELOCATION}" = "${CURVEPROJECT}" ]; then
                CURVEPATH="root"
            else
                CURVEPATH="${TEMPLOCATION}"
            fi
        fi

        case $CURRENTPATH in
        ${CURVESPACE}/${CURVEPROJECT}*)
            echo "${PR_GREEN}$CURVEPROJECT${PR_RESET}${PR_CYAN}$(git_prompt_info)${PR_RESET}${PR_YELLOW}->${PR_RESET}"
        ;;
        *)
            echo "${PR_RED}$CURVEPROJECT${PR_RESET}${PR_YELLOW}->${PR_RESET}"
        ;;
        esac
    fi
}

get_right_prompt() {
    echo "${PR_YELLOW}%~/${PR_RESET}"
}

PROMPT='$(get_prompt)'
RPROMPT='$(get_right_prompt)'

# git theming default: Variables for theming the git info prompt
ZSH_THEME_GIT_PROMPT_PREFIX="(" 
ZSH_THEME_GIT_PROMPT_SUFFIX="${PR_CYAN})${PR_RESET}" 
ZSH_THEME_GIT_PROMPT_DIRTY="${PR_RED}*${PR_RESET}"
ZSH_THEME_GIT_PROMPT_CLEAN="" 
