#!/bin/bash

decrypt () {
  node ./src/shell/decrypt.mjs < "$1"
}

export -f decrypt
