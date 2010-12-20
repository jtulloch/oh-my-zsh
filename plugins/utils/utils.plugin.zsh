edit_plugin() {
    if [ $1 = '' ]; then
        echo "USAGE: edit_plugin <plugin name>"
    fi

    plugin_dir=$ZSH/plugins
    plugin_name=$1

    plugin_path=${plugin_dir}/${plugin_name}/${plugin_name}.plugin.zsh
    vi $plugin_path && source ~/.zshrc
}
