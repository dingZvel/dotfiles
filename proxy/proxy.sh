#!/bin/bash
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
# wslip=$(hostname -I | awk '{print $1}')
port=10811
ALL_PROXY="http://${hostip}:${port}"

function display() {
    echo "Host ip: ${hostip}"
    # echo "WSL client ip: ${wslip}"
    echo "current PROXY: ${ALL_PROXY}"
}

function set_proxy() {
    export ALL_PROXY="${ALL_PROXY}"
    # export https_proxy="${ALL_PROXY}"
    echo "env http/https proxy set."
}

function unset_proxy() {
    unset ALL_PROXY 
    # unset https_proxy
    echo "env proxy unset."
}

function set_git_proxy() {
    git config --global http.proxy "${ALL_PROXY}"
    git config --global https.proxy "${ALL_PROXY}"
    echo "git config proxy set."
}

function unset_git_proxy() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo "git conffig proxy unset."
}

if [ "$1" = "display" ]; then
    display
elif [ "$1" = "set" ]; then
    set_proxy
elif [ "$1" = "unset" ]; then
    unset_proxy
elif [ "$1" = "setgit" ]; then
    set_git_proxy
elif [ "$1" = "ungit" ]; then
    unset_git_proxy
else
    echo "incorrect arguments."
fi
