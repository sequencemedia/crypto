import globals from 'globals'
import jsdoc from 'eslint-plugin-jsdoc'
import merge from '@sequencemedia/eslint-merge'
import standard from '@sequencemedia/eslint-config-standard/merge'
import typescript from '@sequencemedia/eslint-config-typescript/merge'

export default [
  merge(
    jsdoc.configs['flat/recommended'],
    {
      rules: {
        'jsdoc/require-param-description': 'off',
        'jsdoc/require-returns-description': 'off'
      }
    }
  ),
  ...standard({
    files: [
      '**/*.{mjs,cjs,mts,cts}'
    ],
    languageOptions: {
      globals: {
        ...globals.node
      }
    }
  }),
  ...typescript({
    files: [
      '**/*.{mts,cts}'
    ],
    languageOptions: {
      globals: {
        ...globals.node
      }
    }
  })
]
