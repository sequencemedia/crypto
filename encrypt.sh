#!/bin/bash

encrypt () {
  node ./src/shell/encrypt.mjs < "$1"
}

export -f encrypt
