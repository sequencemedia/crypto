#!/bin/bash

encrypt () {
  node ./src/shell/encrypt.mjs < "$1"
}

decrypt () {
  node ./src/shell/decrypt.mjs < "$1"
}

get_args () {
  for flag in "$@";
  do
    shift
    case "$flag" in
      '--origin')
        set -- "$@" '-o'
        ;;
      '--destination')
        set -- "$@" '-d'
        ;;
      *)
        set -- "$@" "$flag"
        ;;
    esac
  done

  while getopts ":o:d:" flag;
  do
    case "${flag}" in
      o)
        export ORIGIN=$OPTARG
        ;;
      d)
        export DESTINATION=$OPTARG
        ;;
    esac
  done
}

export -f encrypt

export -f decrypt
