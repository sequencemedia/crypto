#!/bin/bash

source ./crypto.sh

get_args "$@";

if [[ -z "$ORIGIN" ]];
then
  echo Origin is required
  exit 1
fi

if [[ -z "$DESTINATION" ]];
then
  echo Destination is required
  exit 1
fi

if [ -d "$ORIGIN" ];
then
  if [ -f "$DESTINATION" ];
  then
    echo Origin is a directory but destination is a file
    exit 1
  else
    mkdir -p "$DESTINATION" 2> /dev/null
    encrypt_directory "$ORIGIN" "$DESTINATION"
    exit 0
  fi
else
  if [ -f "$ORIGIN" ];
  then
    if [ -d "$DESTINATION" ];
    then
      echo Origin is a file but destination is a directory
      exit 1
    else
      encrypt "$ORIGIN" > "$DESTINATION"
      exit 0
    fi
  fi
fi

echo Origin is neither a file nor a directory
exit 1
