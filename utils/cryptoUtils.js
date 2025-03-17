const crypto = require('crypto')

const ALGORITHM = 'aes-256-gcm'
const SECRET_KEY = Buffer.from(
  'a3f1b8c0d4e5f2a1c6b7d8e9f01234567890abcdef1234567890abcdef123456',
  'hex'
) // Convert hex string to Buffer
const IV_LENGTH = 12 // IV size for AES-GCM

// Function to encrypt data
function encrypt (text) {
  const iv = crypto.randomBytes(IV_LENGTH)
  const cipher = crypto.createCipheriv(ALGORITHM, SECRET_KEY, iv)
  let encrypted = cipher.update(text, 'utf8', 'hex')
  encrypted += cipher.final('hex')
  const authTag = cipher.getAuthTag().toString('hex')

  return `${iv.toString('hex')}:${encrypted}:${authTag}`
}

// Function to decrypt data
function decrypt (encryptedText) {
  try {
    const [iv, encrypted, authTag] = encryptedText.split(':')
    if (!iv || !encrypted || !authTag)
      throw new Error('Invalid encrypted text format')

    const decipher = crypto.createDecipheriv(
      ALGORITHM,
      SECRET_KEY,
      Buffer.from(iv, 'hex')
    )
    decipher.setAuthTag(Buffer.from(authTag, 'hex'))

    let decrypted = decipher.update(encrypted, 'hex', 'utf8')
    decrypted += decipher.final('utf8')

    return decrypted
  } catch (error) {
    console.error('Decryption failed:', error.message)
    return null
  }
}

module.exports = { encrypt, decrypt }
