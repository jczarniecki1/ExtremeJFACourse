path = require 'path'
rootPath = path.normalize __dirname + '/../../'

module.exports =
  development:
    rootPath: rootPath
    db:'mongodb://localhost/jfa-course'
    port: process.env.PORT || 3030

  production:
    rootPath: rootPath
    db:'mongodb://admin:teach-me@ds047468.mongolab.com:47468/jfa-course'
    port: process.env.PORT || 80