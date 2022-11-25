declare module '@sequencemedia/crypto' {
  export function hashKey(key: string): string
  export function encode(buffer: Buffer, key: string, secret?: string): Buffer
  export function decode(buffer: Buffer, key: string, secret?: string): Buffer
}
