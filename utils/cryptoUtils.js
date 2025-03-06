const crypto = require("crypto");

const ALGORITHM = "aes-256-gcm";
const SECRET_KEY = crypto.randomBytes(32); // Replace this with a securely stored key
const IV_LENGTH = 12; // IV size for AES-GCM

// Function to encrypt data
function encrypt(text) {
  const iv = crypto.randomBytes(IV_LENGTH);
  const cipher = crypto.createCipheriv(ALGORITHM, SECRET_KEY, iv);
  let encrypted = cipher.update(text.toString(), "utf8", "hex");
  encrypted += cipher.final("hex");
  const authTag = cipher.getAuthTag().toString("hex");
  return `${iv.toString("hex")}:${encrypted}:${authTag}`;
}

// Function to decrypt data
function decrypt(encryptedText) {
  const [iv, encrypted, authTag] = encryptedText.split(":");
  const decipher = crypto.createDecipheriv(
    ALGORITHM,
    SECRET_KEY,
    Buffer.from(iv, "hex")
  );
  decipher.setAuthTag(Buffer.from(authTag, "hex"));
  let decrypted = decipher.update(encrypted, "hex", "utf8");
  decrypted += decipher.final("utf8");
  return decrypted;
}

module.exports = { encrypt, decrypt };
