#
#
# This plugin manages selecting from the various
# projest you have on the go.  There are a few
# options that you can override:
#
# PROJECT_PATHS=() - The directories which contain your projects
# PROJECT_LIST_FUNCTION="" - The function to call for a list of projects
# PROJECT_SELECTED_FUNCTION="" - The function to call when a project is selected
#
# The default behaviour is to list all directories in PROJECT_PATHS.  When
# a project is selected it will set the variables $PROJECT_PATH and $PROJECT.
# If you override the selected function via PROJECT_SELECTED_FUNCTION you
# may want to ensure you set these variables as part of that, or call the default
# after performing your specific activities.
#
#

if [ -z "$PROJECT_PATHS" ]; then
    PROJECT_PATHS=($HOME)
fi
PROJECT_LIST_FUNCTION=${PROJECT_LIST_FUNCTION:='get_project_list'}
PROJECT_SELECTED_FUNCTION=${PROJECT_SELECTED_FUNCTION:='project_selected'}

choose_project() {
    project_name=${1:=''}
    if [ -z "${project_name}" ]; then
        choose_project_from_list
    else
        ${PROJECT_SELECTED_FUNCTION} ${project_name}
    fi
}

choose_project_from_list() {
#This is to make the for loop parse by new lines instead of whitespace
IFS_BAK=$IFS
IFS="
"
    select project_name in $($PROJECT_LIST_FUNCTION); do
        if [ -n "$project_name" ]; then
            ${PROJECT_SELECTED_FUNCTION} ${project_name}
            break
        fi
    done

IFS=$IFS_BAK
IFS_BAK=
}

get_project_base_path() {
    project_name=${1:=''}
    if [ -z "${project_name}" ]; then
        echo "$HOME"
        return
    fi

    for project_path ($PROJECT_PATHS); do
        if [ -d "$project_path/${project_name}" ]; then
            echo ${project_path}
            return
        fi
    done
    echo ""
}

get_project_list() {
    for project_path ($PROJECT_PATHS); do
        for project_name in ${project_path}/*; do
            if [ -d "${project_name}" ]; then
                basename $project_name
            fi
        done
    done
}

project_selected() {
    export PROJECT=$1
    export PROJECT_BASE_PATH=$(get_project_base_path $PROJECT)
    export PROJECT_PATH=${PROJECT_BASE_PATH}/${PROJECT}
    cd "$PROJECT_PATH"
}


# add completion function to path
fpath=($ZSH/plugins/project $fpath)
autoload -U compinit
compinit -i
