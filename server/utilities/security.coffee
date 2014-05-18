crypto = require 'crypto'

module.exports =
  {
    createSalt: ()->
      crypto.randomBytes 128
        .toString 'base64'

    hashPwd: (salt, pwd) ->
      hmac = crypto.createHmac('sha1', salt);
      hmac.update pwd
        .digest 'hex'
  }