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

decrypt "$ORIGIN" > "$DESTINATION"
exit 0
