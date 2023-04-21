# @sequencemedia/crypto

Encrypt and decrypt in Node and Bash

## Node

The package _main_ exports two functions, `encrypt` and `decrypt`

```javascript
import {
  encrypt,
  decrypt
} from '@sequencemedia/crypto'
```

### `encrypt`

```typescript
function encrypt(
  buffer: Buffer,
  secret: string,
  bytes?: number,
  algorithm?: string
): Buffer
```

Only `buffer` and `secret` are _required_

- `buffer` is the data to encrypt
- `secret` is the secret key to use for encryption

Both `bytes` and `algorithm` are _optional_

- `bytes` is the number of random bytes to use for the encryption _initialisation vector_. The default is `16`
- `algorithm` is the algorithm to use for encryption. The default is `aes-256-ctr`

### `decrypt`

```typescript
function decrypt(
  buffer: Buffer,
  secret: string,
  bytes?: number,
  algorithm?: string
): Buffer
```

Only `buffer` and `secret` are _required_

- `buffer` is the data to decrypt
- `secret` is the secret key to use for decryption

Both `bytes` and `algorithm` are _optional_

- `bytes` is the number of bytes to slice from the buffer for the decryption _initialisation vector_. The default is `16`
- `algorithm` is the algorithm to use for decryption. The default is `aes-256-ctr`

## Bash

The package contains three scripts

1. `crypto.sh`
1. `encrypt.sh`
2. `decrypt.sh`

Script `crypto.sh` exports four functions to consume in your own Bash scripts

```bash
source ./crypto.sh
```

1. `encrypt`
2. `decrypt`
3. `encrypt_directory`
4. `decrypt_directory`

Scripts [`encrypt.sh`](#encryptsh) and [`decrypt.sh`](#decryptsh) can be executed at the command line

### Bash functions

#### `encrypt`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment and a file path to _encrypt_

```bash
CRYPTO_KEY='secret'
encrypted_file_data=$(encrypt "./file.txt")
```

```bash
CRYPTO_KEY='secret'
encrypt "./file.txt" > "./encrypted.txt"
```

#### `decrypt`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment and a file path to _decrypt_

```bash
CRYPTO_KEY='secret'
file_data=$(decrypt "./encrypted.txt")
```

```bash
CRYPTO_KEY='secret'
decrypt "./encrypted.txt" > "./file.txt"
```

#### `encrypt_directory`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment and a directory path to _encrypt_

- The first argument is the origin directory of files to _encrypt_
- The second argument is the destination directory for the _encrypted_ files

```bash
CRYPTO_KEY='secret'
encrypt_directory "./directory" "./encrypted"
```

#### `decrypt_directory`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment and a directory path to _decrypt_

- The first argument is the origin directory of files to _decrypt_
- The second argument is the destination directory for the _decrypted_ files

```bash
CRYPTO_KEY='secret'
decrypt_directory "./encrypted" "./directory"
```

### Bash scripts

#### `encrypt.sh`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment

- You can provide either _file_ or _directory_ paths
- You can provide `--verbose` or `-v`

##### File paths

- A file _origin_ path to _encrypt_
- A file _destination_ path for the _encrypted_ file

```bash
CRYPTO_KEY='secret' ./encrypt.sh \
  --origin "./file.txt" \
  --destination "./encrypted.txt"
```

##### Directory paths

- A directory _origin_ path to _encrypt_
- A directory _destination_ path for _encrypted_ files

```bash
CRYPTO_KEY='secret' ./encrypt.sh \
  --origin "./directory" \
  --destination "./encrypted"
```

#### `decrypt.sh`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment

- You can provide either _file_ or _directory_ paths
- You can provide `--verbose` or `-v`

##### File paths

- A file _origin_ path to _decrypt_
- A file _destination_ path for the _decrypted_ file

```bash
CRYPTO_KEY='secret' ./decrypt.sh \
  --origin "./encrypted.txt" \
  --destination "./file.txt"
```

##### Directory paths

- A directory _origin_ path to _decrypt_
- A directory _destination_ path for _decrypted_ files

```bash
CRYPTO_KEY='secret' ./decrypt.sh \
  --origin "./encrypted" \
  --destination "./directory"
```
