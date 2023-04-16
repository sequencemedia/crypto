declare module '@sequencemedia/crypto' {
  export function hashKey(secret: string): string
  export function encrypt(buffer: Buffer, secret: string, bytes?: number, algorithm?: string): Buffer
  export function decrypt(buffer: Buffer, secret: string, bytes?: number, algorithm?: string): Buffer
}
