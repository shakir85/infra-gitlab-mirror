#!/bin/bash
set -e



# -- Terminal colors ----------------------------------
tput() {
  command -v tput >/dev/null && command tput "$@"
}
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset_color=$(tput sgr0)

# -- Custom echo messages -----------------------------
error(){
    echo "${red}=> error:${reset_color} $* " 
}
info(){
    echo "${green}=> info:${reset_color} $* " >>/dev/stdout
}
warning(){
    echo "${yellow}=> warning:${reset_color} $* " >>/dev/stdout
}

# -- Variables ---------------------------------------
USER=$1
PUB_KEY_FILE_PATH=$2

info "Setting remote_user..."

if [ "$USER" == "" ]; then
    warning "You didn't provide a remote_user, specify a username that exists on the remote host"
    exit 1
fi

if [ "$PUB_KEY_FILE_PATH" == "" ]; then
    error "Pass the absolute path to id_rsa.pub"
    exit 1
else
    info "Bootstrapping using:
    remote_user = $USER
    public key = $PUB_KEY_FILE_PATH"
    sleep 5
    echo ""
    ansible-playbook bootstrap.playbook.yml -u "$USER" --extra-vars="pub_ssh_key_file=$PUB_KEY_FILE_PATH"
fi
