passport = require('passport')

exports.getLogin = (req, res) ->
  error = req.flash('loginMessage')
  res.render 'login', message: error: if error.length then error else null
  return

exports.postLogin = passport.authenticate('local-login',
  successRedirect: '/search'
  failureRedirect: '/login'
  failureFlash: true)

exports.getSignup = (req, res) ->
  error = req.flash('signupMessage')
  console.log error
  res.render 'signup', message: error: if error.length then error else null
  return

exports.postSignup = passport.authenticate('local-signup',
  successRedirect: 'search'
  failureRedirect: 'signup'
  failureFlash: true)

exports.getHome = (req, res) ->
  req.session.messages = req.session.messages or []
  message = req.session.messages.pop()
  res.render 'home',
    title: 'Email Hunter'
    user: req.user
    message: message

exports.logout = (req, res) ->
  req.logout()
  res.redirect '/'
