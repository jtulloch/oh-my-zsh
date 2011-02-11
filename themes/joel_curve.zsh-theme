autoload colors; colors

for COLOR in RED GREEN BLUE YELLOW WHITE BLACK CYAN; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

PR_RESET="%{${reset_color}%}";

MODE_INDICATOR="command_mode"

get_prompt() {
    CURRENTPATH=`pwd`
    if [ "${CURVEPROJECT}" = "" ]; then
        prmpt="${PR_CYAN}%n@%m${PR_RESET}${PR_CYAN}$(git_prompt_info)${PR_RESET}"
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
            prmpt="${PR_GREEN}$CURVEPROJECT${PR_RESET}${PR_CYAN}$(git_prompt_info)${PR_RESET}"
        ;;
        *)
            prmpt="${PR_RED}$CURVEPROJECT${PR_RESET}"
        ;;
        esac
    fi
    mode=$(vi_mode_prompt_info)
    command_indicator="(i)"

    if [ "$mode" = "command_mode" ]; then
        command_indicator="(c)"
    fi

    prmpt="${prmpt}${command_indicator}${PR_GREEN}->${PR_RESET}"
    echo $prmpt
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
