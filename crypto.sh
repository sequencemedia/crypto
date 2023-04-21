#!/bin/bash

VERBOSE=false

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
      '--verbose')
        set -- "$@" '-v'
        ;;
      *)
        set -- "$@" "$flag"
        ;;
    esac
  done

  while getopts ":o:d:v" flag;
  do
    case "${flag}" in
      o)
        export ORIGIN=$OPTARG
        ;;
      d)
        export DESTINATION=$OPTARG
        ;;
      v)
        VERBOSE=true
        ;;
      *)
        echo Ignoring "$flag"
        ;;
    esac
  done
}

get_path () {
  local absolute_path

  case "${1}" in
    [./]*)
      absolute_path="$(cd "${1%/*}" || exit; pwd)/${1##*/}"
      ;;
    *)
      absolute_path="${!PWD}/${1}"
      ;;
  esac

  # shellcheck disable=SC2001
  echo "$(sed "s,/$,," <<< "$absolute_path")"
}

encrypt () {
  node ./src/shell/encrypt.mjs < "$1"
}

decrypt () {
  node ./src/shell/decrypt.mjs < "$1"
}

encrypt_directory () {
  local current_directory
  local destination_directory
  local directory_root

  current_directory=$(get_path "$1")
  destination_directory=$(get_path "$2")
  directory_root=$(get_path "${3-$1}")

  for child in "$current_directory"/*;
  do
    # Recurse $child directory
    if [ -d "$child" ];
    then
      local file_path

      [[ "$child" =~ "$directory_root"/(.*)$ ]] && file_path="${BASH_REMATCH[1]}"

      mkdir -p "$destination_directory/$file_path"

      local directory="$child"

      [[ $VERBOSE == true ]] && echo Recursing into "$directory"

      encrypt_directory "$directory" "$destination_directory" "$directory_root"
    else
      # Ensure $child is a file (not "/*")
      if [ -f "$child" ];
      then
        local file_name

        [[ "$child" =~ "$directory_root"/(.*) ]] && file_name="${BASH_REMATCH[1]}"

        mkdir -p "$destination_directory"

        local file="$child"

        [[ $VERBOSE == true  ]] && echo Encrypting "$file"

        encrypt "$file" > "$destination_directory/$file_name"
      fi
    fi
  done
}

decrypt_directory () {
  local current_directory
  local destination_directory
  local directory_root

  current_directory=$(get_path "$1")
  destination_directory=$(get_path "$2")
  directory_root=$(get_path "${3-$1}")

  for child in "$current_directory"/*;
  do
    # Recurse $child directory
    if [ -d "$child" ];
    then
      local file_path

      [[ "$child" =~ "$directory_root"/(.*)$ ]] && file_path="${BASH_REMATCH[1]}"

      mkdir -p "$destination_directory/$file_path"

      local directory

      directory="$child"

      [[ $VERBOSE == true ]] && echo Recursing into "$directory"

      decrypt_directory "$directory" "$destination_directory" "$directory_root"
    else
      # Ensure $child is a file (not "/*")
      if [ -f "$child" ];
      then
        local file_name

        [[ "$child" =~ "$directory_root"/(.*) ]] && file_name="${BASH_REMATCH[1]}"

        mkdir -p "$destination_directory"

        local file

        file="$child"

        [[ $VERBOSE == true ]] && echo Decrypting "$file"

        decrypt "$file" > "$destination_directory/$file_name"
      fi
    fi
  done
}

export -f encrypt

export -f decrypt

export -f encrypt_directory

export -f decrypt_directory
