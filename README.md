# @sequencemedia/crypto

Encrypt and decrypt in Node and Bash

## Node

Exports two functions, `encrypt` and `decrypt`

```javascript
import {
  encrypt,
  decrypt
} from '@sequencemedia/crypto'
```

### `encrypt`

```typescript
function encrypt(buffer: Buffer, secret: string, bytes?: number, algorithm?: string): Buffer
```

Only `buffer` and `secret` are _required_

- `buffer` is the data to encrypt
- `secret` is the secret key to use for encryption

Both `bytes` and `algorithm` are _optional_

- `bytes` is the number of random bytes to use for the encryption _initialisation vector_. The default is `16`
- `algorithm` is the algorithm to use for encryption. The default is `aes-256-ctr`

### `decrypt`

```typescript
function decrypt(buffer: Buffer, secret: string, bytes?: number, algorithm?: string): Buffer
```

Only `buffer` and `secret` are _required_

- `buffer` is the data to decrypt
- `secret` is the secret key to use for decryption

Both `bytes` and `algorithm` are _optional_

- `bytes` is the number of bytes to slice from the buffer for the decryption _initialisation vector_. The default is `16`
- `algorithm` is the algorithm to use for decryption. The default is `aes-256-ctr`

## Bash

Exports two functions, `encrypt` and `decrypt`

```bash
source ./crypto.sh
```

### `encrypt`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment and a file path to _encrypt_

```bash
encrypted_file_data=$(encrypt "./file.txt")
```

```bash
encrypt "./file.txt" > "./encrypted.txt"
```

### `decrypt`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment and a file path to _decrypt_

```bash
CRYPTO_KEY='secret'
file_data=$(decrypt "./encrypted.txt")
```

```bash
CRYPTO_KEY='secret'
decrypt "./encrypted.txt" > "./file.txt"
```

## Bash scripts

### `encrypt.sh`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment

- A file _origin_ path for data to _encrypt_
- A file _destination_ path to put the encrypted data

```bash
CRYPTO_KEY='secret' ./encrypt.sh --origin "./file.txt" --destination "./encrypted.txt"
```

### `decrypt.sh`

Requires `CRYPTO_KEY` as a _variable_ in the Bash environment

- A file _origin_ path for data to _decrypt_
- A file _destination_ path to put the decrypted data

```bash
CRYPTO_KEY='secret' ./decrypt.sh --origin "./encrypted.txt" --destination "./file.txt"
```
