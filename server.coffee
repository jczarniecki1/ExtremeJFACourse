express = require 'express'
mongoose = require 'mongoose'

env = process.env.NODE_ENV = process.env.NODE_ENV || 'development'

app = express()

# configure server behaviour
#
app.configure ->
  app.set 'views', __dirname + '/server/views'
  app.set 'view engine', 'jade'
  app.use express.logger 'dev'
  app.use express.static __dirname + '/public'

# configure database connection
#
if env == 'development'
  mongoose.connect 'mongodb://localhost/jfa-course'
else
  mongoose.connect 'mongodb://admin:teach-me@ds047468.mongolab.com:47468/jfa-course'

db = mongoose.connection
db.on 'error', console.error.bind(console,'connection error...')
db.once 'open', ->
  console.log 'Database opened successfully'

messageSchema = mongoose.Schema
  message: String

Message = mongoose.model 'Message', messageSchema

mongoMessage = 'Connecting to database...'
Message.findOne().exec (err, messageDoc)->
  mongoMessage = messageDoc.message


# configure routing
#
app.get '/partials/:partialPath', (req, res) ->
  res.render 'partials/' + req.params.partialPath

app.get '/', (req, res) ->
  res.render 'index',
    mongoMessage: mongoMessage

# start the server
#
port = process.env.PORT || 3030;
app.listen port
console.log 'Listening on port ' + port + '...'