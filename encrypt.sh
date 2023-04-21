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
  if [ -d "$DESTINATION" ];
  then
    encrypt_directory "$ORIGIN" "$DESTINATION"
    exit 0
  else
    echo Origin is a directory but destination is not a directory
    exit 1
  fi
fi

encrypt "$ORIGIN" > "$DESTINATION"
exit 0
