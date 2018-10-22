#! /bin/bash

read_var() {
    VAR=$(grep -i $2 $1 | xargs -d '\n')
    IFS="=" read -ra VAR <<< "$VAR"
    echo ${VAR[1]}
}

git config --global user.email $(read_var .env GIT_EMAIL)
git config --global user.name $(read_var .env GIT_NAME)
