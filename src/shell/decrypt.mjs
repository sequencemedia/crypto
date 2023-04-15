#!/usr/bin/env node

import {
  decrypt
} from '@sequencemedia/crypto'

const {
  env: {
    CRYPTO_KEY
  } = {},
  stdout,
  openStdin
} = process

let collector = Buffer.from('')

openStdin()
  .on('data', (buffer) => {
    collector = Buffer.concat([collector, buffer])
  })
  .on('end', () => {
    stdout.write(decrypt(collector, CRYPTO_KEY))
  })
