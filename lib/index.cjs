"use strict";Object.defineProperty(exports,"__esModule",{value:true});exports.decrypt=decrypt;exports.encrypt=encrypt;exports.hashKey=hashKey;var _crypto=_interopRequireDefault(require("crypto"));function _interopRequireDefault(obj){return obj&&obj.__esModule?obj:{default:obj};}function hashKey(key){if(!key)throw new Error('A key is required');return _crypto.default.createHash('sha256').update(key).digest('base64').substring(0,32);}function encrypt(buffer,key,algorithm='aes-256-ctr'){const iv=_crypto.default.randomBytes(16);const cipher=_crypto.default.createCipheriv(algorithm,hashKey(key),iv);return Buffer.concat([iv,cipher.update(buffer),cipher.final()]);}function decrypt(buffer,key,algorithm='aes-256-ctr'){const iv=buffer.slice(0,16);const decipher=_crypto.default.createDecipheriv(algorithm,hashKey(key),iv);return Buffer.concat([decipher.update(buffer.slice(16)),decipher.final()]);}