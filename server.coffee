express = require('express')
mongoose = require('mongoose')
passport = require('passport')
path = require('path')

config = require('./config')

app = express()

mongoose.connect config.db.url
db = mongoose.connection
db.on 'error', console.error.bind(console, 'connection error:')
db.once 'open', ->
  console.log 'Database Connection Status: ' + mongoose.connection.readyState
  return

if process.env.NODE_ENV == 'development'
  require './utils/seed'

require('./utils/passport') passport
require('./utils/appMiddleware') app

app.use express.static(path.join(__dirname, '../', 'public'), maxAge: 31557600000)
app.use express.static(path.join(__dirname, '../', 'views'))
app.use passport.initialize()
app.use passport.session()

require('./routers') app, passport

app.listen config.port
console.log 'http://localhost:' + config.port
exports = app
