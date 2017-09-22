bodyParser = require('body-parser')
methodOverride = require('method-override')
helmet = require('helmet')
morgan = require('morgan')
session = require('express-session')
flash = require('connect-flash')
path = require('path')
sass = require('node-sass-middleware')

module.exports = (app) ->
  app.set 'view engine', 'pug'
  app.use helmet()
  app.use sass(
    src: path.join(__dirname, '../../', 'public')
    dest: path.join(__dirname, '../../', 'public')
    debug: true
    outputStyle: 'compressed')
  # app.use(morgan('dev'));
  app.use bodyParser.json()
  app.use bodyParser.json(type: 'application/vnd.api+json')
  app.use bodyParser.urlencoded(extended: true)
  app.use methodOverride('X-HTTP-Method-Override')
  app.use session(secret: 'dog')
  app.use flash()
