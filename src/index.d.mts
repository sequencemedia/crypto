/**
 * @param {string} secret
 * @returns {string}
 */
export function hashKey (secret: string): string
/**
 * @param {Buffer} buffer
 * @param {string} secret
 * @param {number} [bytes]
 * @param {string} [algorithm]
 * @returns {Buffer}
 */
export function encrypt (buffer: Buffer, secret: string, bytes?: number, algorithm?: string): Buffer
/**
 * @param {Buffer} buffer
 * @param {string} secret
 * @param {number} [bytes]
 * @param {string} [algorithm]
 * @returns {Buffer}
 */
export function decrypt (buffer: Buffer, secret: string, bytes?: number, algorithm?: string): Buffer
