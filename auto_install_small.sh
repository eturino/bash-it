#!/usr/bin/env bash
BASH_IT="$HOME/.bash_it"

test -w $HOME/.bash_profile &&
  cp $HOME/.bash_profile $HOME/.bash_profile.bak &&
  echo "Your original .bash_profile has been backed up to .bash_profile.bak"

cp $HOME/.bash_it/template/bash_profile.template.bash $HOME/.bash_profile

echo "Copied the template .bash_profile into ~/.bash_profile, edit this file to customize bash-it"

small_aliases=( "general" "bundler" "rails" )
small_plugins=( )
small_completion=( "bash-it" "gem" "git" "ssh" )

function load_small() {
  file_type=$1
  declare -a argAry2=("${!2}")

  [ ! -d "$BASH_IT/$file_type/enabled" ] && mkdir "$BASH_IT/${file_type}/enabled"

  for name in "${argAry2[@]}"
  do
    src="$BASH_IT/$file_type/available/${name}.aliases.bash"
    filename="$(basename ${src})"
    [ ${filename:0:1} = "_" ] && continue
      dest="${BASH_IT}/${file_type}/enabled/${filename}"
      if [ ! -e "${dest}" ]; then
          ln -s "${src}" "${dest}"
      else
          echo "File ${dest} exists, skipping"
      fi
  done
}

load_small "aliases" small_aliases[@]
load_small "plugins" small_plugins[@]
load_small "completion" small_completion[@]
