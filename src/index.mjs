import crypto from 'node:crypto'

/**
 * @param {string} secret
 * @returns {string}
 */
function hashKey (secret) {
  if (!secret) throw new Error('A secret is required')

  return crypto.createHash('sha256').update(secret).digest('base64').substring(0, 32)
}

/**
 * @param {Buffer} buffer
 * @param {string} secret
 * @param {number} [bytes]
 * @param {string} [algorithm]
 * @returns {Buffer}
 */
export function encrypt (buffer, secret, bytes = 16, algorithm = 'aes-256-ctr') {
  const iv = crypto.randomBytes(bytes)
  const cipher = crypto.createCipheriv(algorithm, hashKey(secret), iv)
  return Buffer.concat([iv, cipher.update(buffer), cipher.final()])
}

/**
 * @param {Buffer} buffer
 * @param {string} secret
 * @param {number} [bytes]
 * @param {string} [algorithm]
 * @returns {Buffer}
 */
export function decrypt (buffer, secret, bytes = 16, algorithm = 'aes-256-ctr') {
  const iv = buffer.slice(0, bytes)
  const decipher = crypto.createDecipheriv(algorithm, hashKey(secret), iv)
  return Buffer.concat([decipher.update(buffer.slice(bytes)), decipher.final()])
}
