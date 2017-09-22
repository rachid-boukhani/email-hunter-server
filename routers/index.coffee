path = require('path')
isLoggedIn = require('../utils/loggedIn')
searchRouter = require('./search')
loginRouter = require('./login')
hunterRouter = require('./hunter')

module.exports = (app) ->
  app.use '/', loginRouter
  app.use '/search', isLoggedIn, searchRouter
  app.use '/run', isLoggedIn, hunterRouter
  app.use (error, req, res, next) ->
    console.log error
    req.session.messages = req.session.messages or []
    req.session.messages.push error: 'failed'
    res.redirect '/'
