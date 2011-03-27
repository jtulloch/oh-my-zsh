autoload colors; colors

for COLOR in RED GREEN BLUE YELLOW WHITE BLACK CYAN MAGENTA; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

PR_RESET="%{${reset_color}%}";

MODE_INDICATOR='command_mode'
get_prompt() {
    case $(get_location) in
        'ACTIVE_PROJECT')
            prmpt="%{\e[38;05;213m%}${PROJECT}"
            ;;
        'GIT_PROJECT')
            project_name=`basename $(git rev-parse --show-toplevel 2> /dev/null)`
            prmpt="${PR_RED}${project_name}"
            ;;
        *)
            prmpt="${PR_YELLOW}%2d"
            ;;
    esac


    prefix="${PR_GREEN}[%n${PR_WHITE}%M@: "

    vi_mode=$(vi_mode_prompt_info)
    postfix_color="${PR_GREEN}"
    if [ "${vi_mode}" = "command_mode" ]; then
        postfix_color="${PR_BRIGHT_MAGENTA}"
    fi
    postfix="${PR_WHITE}$(git_prompt_info)${postfix_color}]${PR_RESET} "

    echo "${prefix}${prmpt}${postfix}"
}

get_rprompt() {
    print_path=`pwd`

    prefix="[${PR_CYAN}"
    postfix="${PR_WHITE}]"
    case $(get_location) in
        ACTIVE_PROJECT)
            print_path="${print_path##${PROJECT_PATH}}"
            ;;
        GIT_PROJECT)
            git_project_root=$(git rev-parse --show-toplevel 2> /dev/null)
            print_path="${print_path##${git_project_root}}"
            ;;
        *)
            print_path="${print_path}"
    esac

    if [ -z "$print_path" ]; then
        print_path='root'
    fi

    echo "${prefix}${print_path}${postfix}"
}

get_location() {
    CURRENTPATH=`pwd`
    current_project_path=`git rev-parse --show-toplevel 2> /dev/null`
    if [ -z "$current_project_path" ]; then
        current_project_path='NO_POSSIBLE_DIRECTORY'
    fi

    case $CURRENTPATH in
        ${PROJECT_PATH}*) 
            echo "ACTIVE_PROJECT"
            ;;
        ${current_project_path}*) 
            echo "GIT_PROJECT"
            ;;
    esac
}

ZSH_THEME_GIT_PROMPT_PREFIX=" ("
ZSH_THEME_GIT_PROMPT_SUFFIX=")"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"

export PS1='$(get_prompt)'
export RPROMPT='$(get_rprompt)'
setopt prompt_subst

