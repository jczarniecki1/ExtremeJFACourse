require './server/utilities/response'
require './server/utilities/utils'
express = require 'express'

env = process.env.NODE_ENV = process.env.NODE_ENV || 'development'

app = express()

config = require('./server/config/config')[env]

require('./server/config/express')(app, config)

require('./server/config/mongoose')(config)

require('./server/config/passport')()

require('./server/config/routes')(app)

# start the server
#
app.listen config.port
console.log 'Listening on port ' + config.port + '...'